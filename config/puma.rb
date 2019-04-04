# Change to match your CPU core count
workers 4

# Min and Max threads per worker
threads 2, 8

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end

if ENV.fetch("RAILS_ENV") == 'production'
ssl_bind '127.0.0.1', '443', {
    key: ENV.fetch("SSL_KEY_PATH"),
    cert: ENV.fetch("SSL_CERT_PATH"),
    verify_mode: 'none'
}
end