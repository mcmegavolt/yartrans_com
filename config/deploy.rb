require "rvm/capistrano"
require "bundler/capistrano"
require "capistrano-unicorn"

set :using_rvm, true
set :rvm_type, :system

set :application, 'yartrans'
set :user, 'root'

set :deploy_to, "/srv/#{application}"
set :deploy_via, :copy
set :normalize_asset_timestamps, false
set :scm, :git
set :repository,  ".git"

server "91.223.223.135", :web, :app, :db, :primary => true

set :keep_releases, 4

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :migrate_database do
    run "cd '#{current_path}' && #{rake} db:migrate RAILS_ENV=#{rails_env}"
  end
end

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'  # app preloaded

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