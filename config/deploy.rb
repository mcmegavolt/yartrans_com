require "rvm/capistrano"
require "bundler/capistrano"
#require "whenever/capistrano"
#require "delayed/recipes"
#require 'thinking_sphinx/deploy/capistrano'

#set :rails_env, "production" #added for delayed job
set :using_rvm, true
set :rvm_type, :system

#set :whenever_command, "bundle exec whenever"

set :application, "yartrans"
set :user, "yartrans"
set :password, "YaRtRaN8*pa88w0rd"
set :use_sudo, false

set :ssh_options, { :paranoid => false }

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy
set :normalize_asset_timestamps, false
set :scm, :git
set :repository,  ".git"
set :branch, "master"

server "vps.yartrans.ua", :web, :app, :db, :primary => true

set :keep_releases, 10

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  #task :sitemap_refresh do
  #  run "cd '#{current_path}' && #{rake} sitemap:refresh RAILS_ENV=#{rails_env}"
  #end

  task :migrate_database do
    run "cd '#{current_path}' && #{rake} db:migrate RAILS_ENV=#{rails_env}"
  end

end



#after "deploy:stop",    "delayed_job:stop"
#after "deploy:start",   "delayed_job:start"
#after "deploy:restart", "delayed_job:restart"

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

  after       "deploy:finalize_update",
              "uploads:symlink",
              #"deploy:sitemap_refresh",
              "deploy:migrate_database"
  on :start,  "uploads:register_dirs"

end



#before 'deploy:update_code', 'thinking_sphinx:stop'
#after 'deploy:update_code', 'thinking_sphinx:start'
#
#namespace :sphinx do
#  desc "Symlink Sphinx indexes"
#  task :symlink_indexes, :roles => [:app] do
#    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
#  end
#end
#
#after 'deploy:finalize_update', 'sphinx:symlink_indexes'