require "rvm/capistrano"
require "bundler/capistrano"
require "delayed/recipes"
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :rails_env, "production" #added for delayed job  


set :rvm_type, :system  # Copy the exact line. I really mean :user here
set :rvm_path, "/usr/local/rvm"

set :application, "yartrans"
set :scm, :git
set :repository,  ".git"
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

# set :rake, "#{rake} --trace"

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

  task :migrate_database do
    run "cd '#{current_path}' && #{rake} db:migrate RAILS_ENV=#{rails_env}"
  end

end

# ==============================
# Uploads
# ==============================

namespace :uploads do

  desc <<-EOD
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  EOD
  task :setup, :except => { :no_release => true } do
    run "#{try_sudo} mkdir -p #{shared_path}/uploads"
    run "#{try_sudo} chmod 0777 -R #{shared_path}/uploads"
  end

  desc <<-EOD
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  EOD
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc <<-EOD
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.
  EOD
  task :register_dirs do
    set :uploads_dirs,    %w(uploads)
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after       "deploy:finalize_update", "uploads:symlink", "deploy:migrate_database"
  on :start,  "uploads:register_dirs"

end

after  "deploy:finalize_update", "deploy:migrate_database"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"