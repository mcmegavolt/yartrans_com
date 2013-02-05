# 4 workers is enough for our app
worker_processes 4

# App location
@basic_path = "/srv/yartrans"
@app = "#{@basic_path}/current"

# Listen on fs socket for better performance
listen "#{@basic_path}/shared/unicorn.sock", :backlog => 64

# Nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# App PID
pid "#{@basic_path}/shared/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, some applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "#{@basic_path}/shared/log/unicorn.stderr.log"
stdout_path "#{@basic_path}/shared/log/unicorn.stdout.log"

# To save some memory and improve performance
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

# Force the bundler gemfile environment variable to
# reference the Сapistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(@app, 'Gemfile')
end

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end