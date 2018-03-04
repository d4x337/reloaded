listen "/var/www/apps/tortuga/tmp/unicorn.sock", :backlog => 1024
listen "127.0.0.1:3000", :tcp_nopush => true

timeout 300
worker_processes 8
preload_app true

# You can listen on a port or a socket. Listening on a socket is good in a production environment, but listening on a port can be useful for local
# debugging purposes.
#listen '/var/www/apps/tortuga/tmp/unicorn.sock', :backlog => 1024 if ENV['RAILS_ENV'] == 'production'

# For development, you may want to listen on port 3000 so that you can make sure your unicorn.rb file is soundly configured.
listen(3000, backlog: 64) if ENV['RAILS_ENV'] == 'development'

if ENV['RAILS_ENV'] == 'development'
  listen 3000
end

before_fork do |server, worker|
  if defined? ActiveRecord::Base
    ActiveRecord::Base.connection.disconnect!
  end

  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  if defined?(Resque)
    Resque.redis = ENV['REDIS_URI']
    Rails.logger.info('Connected to Redis')
  end
end

