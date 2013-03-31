require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_type, :system  # Copy the exact line. I really mean :user here

set :application, "yartrans"
set :scm, :git
set :repository,  ".git"
# set :repository,  "/home/megavolt/Ubuntu\ One/rails_projects/yartrans/.git"
# set :branch, "master"
set :branch, "develop"

role :web, "vps.yartrans.ua"                          # Your HTTP server, Apache/etc
role :app, "vps.yartrans.ua"                          # This may be the same as your `Web` server
role :db,  "vps.yartrans.ua", :primary => true # This is where Rails migrations will run

set :ssh_options, { :forward_agent => true, :paranoid => false }

set :user, "yartrans"
set :password, "YaRtRaN8*pa88w0rd"
set :use_sudo, false
set :deploy_via, :copy
set :copy_exclude, [".git"]
set :deploy_to, "/home/yartrans/yartrans"
set :normalize_asset_timestamps, false

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :keep_releases, 10

# namespace :rvm do
#   task :trust_rvmrc do
#     run "rvm rvmrc trust #{release_path}"
#   end
# end
# after "deploy", "rvm:trust_rvmrc"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
# В случае с Rails 3 приложениями стоит заменять bundle exec unicorn_rails на bundle exec unicorn
namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end
