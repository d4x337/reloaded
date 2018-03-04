# Author: Davide Gonnella
# config valid only for Capistrano 3.2
role :app, %w{root@192.168.22.104}
role :web, %w{root@192.168.22.104}
role :db,  %w{root@192.168.22.104}

#server '192.168.22.104', user: 'd4x', password: 'Pl0kta...', port: '22',roles: %w{web app}, my_property: :my_value

#server '192.168.22.104', user: 'r', password: 'Pl0kta...', port: '22',roles: %w{web app}, my_property: :my_value

set :stage, :test
lock '3.2.1'

set :application, 'qoe-dashboard'
set :repo_url,  'gituser@192.168.90.59:bes/besuite.git'
#set :repo_path, '/var/www/repository'

set :branch, 'f-1308-group-chart-support'

set :default_shell, 'bash -l'
set :stages, %w(test)
set :default_stage, 'test'

set :user, 'd4x'
set :group, 'adb'
set :use_sudo, false
set :rake, 'bundle exec rake'
set :stage, :test
set :scm, :git
set :rails_env, 'test'

set :bundle_flags, '--deployment --quiet'
set :rvm_ruby_string, '2.0.0p481'
set :rbenv_ruby, '2.0.0'

#set :migrate_env,    "production"

#set :deploytag_time_format, "%Y.%m.%d-%H%M%S-CET"

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/tmpdeploy'

# Default value for :scm is :git
set :scm, :git

# release id is just the commit hash used to create the tarball.
set :project_release_id, `git log --pretty=format:'%h' -n 1 HEAD`

# the same path is used local and remote... just to make things simple for who wrote this.
set :project_tarball_path, "/tmp/#{fetch(:application)}-#{fetch(:project_release_id)}.tar.gz"

# We create a Git Strategy and tell Capistrano to use it, our Git Strategy has a simple rule: Don't use git.
module NoGitStrategy
  def check
    true
  end

  def test
    # Check if the tarball was uploaded.
    test! " [ -f #{fetch(:project_tarball_path)} ] "
  end

  def clone
    true
  end

  def update
    true
  end

  def release
    # Unpack the tarball uploaded by deploy:upload_tarball task.
    context.execute "tar -xf #{fetch(:project_tarball_path)} -C #{release_path}"
    # Remove it just to keep things clean.
    context.execute :rm, fetch(:project_tarball_path)
  end

  def fetch_revision
    # Return the tarball release id, we are using the git hash of HEAD.
    fetch(:project_release_id)
  end
end

# Capistrano will use the module in :git_strategy property to know what to do on some Capistrano operations.
set :git_strategy, NoGitStrategy

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true
set :ssh_options, { :forward_agent => true }

# Default value for :linked_files is []
#set :linked_files, %w{ config/database.yml}

# Default value for linked_dirs is []
#set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 3

namespace :deploy do

  desc 'Symlink Shared Configs'
  task :finalize_update do
    system("ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml")
  end

  desc 'Start Server'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      system("cd #{current_path} && bundle exec unicorn -p 23000 &")
    end
  end

  desc 'Kill Server'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      system("ps x | grep 'unicorn master' | grep -v grep | head -n 1 | awk '{print $1}' | xargs kill;")
    end
  end

  desc 'Precompile Assets'
  task :precompile do
    system("bundle exec rake assets:precompile")
  end
  
  desc 'Bundle Install New Release'
  task :bundle_new_release do
    on roles :all do
      within release_path do
        with rails_env: fetch(:rails_env) do
          puts "Bundle Check"
          system("bundle check")
          
          puts "Precomiling Assets"
          system("bundle exec rake assets:precompile")
          
          puts "Bundle Install"
          system("bundle install --path vendor/bundle")
        end
      end
    end
  end
 
  task :migrate do
    on roles :all do
      with rails_env: fetch(:rails_env) do
        puts "DB Migrations"
        system("rake db:migrate")
      end
    end
  end
  
  task :create_tarball do |task, args|
    tarball_path = fetch(:project_tarball_path)
    puts 'Create Project Tarball'
    # This will create a project tarball from HEAD, stashed and not committed changes wont be released.
   `git archive -o #{tarball_path} HEAD`
    raise 'Error creating tarball.'if $? != 0
    on roles(:all) do
      upload! tarball_path, tarball_path
    end
  end
  
  after :finished, :set_current_version do
    on roles(:app) do
      # dump current git version
      within release_path do
      # execute :echo, "#{capture("cd #{repo_path} && git rev-parse --short HEAD")} >> public/version"
      end
    end
  end
  
  before 'deploy:updating', 'deploy:create_tarball'
 
  after 'deploy:updating', :migrate
 
  before :publishing, :bundle_new_release
  
  after :publishing, :restart
  
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

end
