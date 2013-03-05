


set :application, "yartrans"
set :scm, :git
set :repository,  ".git"
set :branch, "master"


role :web, "vps.yartrans.ua"                          # Your HTTP server, Apache/etc
role :app, "vps.yartrans.ua"                          # This may be the same as your `Web` server
role :db,  "vps.yartrans.ua", :primary => true # This is where Rails migrations will run
role :db,  "vps.yartrans.ua"


set :ssh_options, { :forward_agent => true, :paranoid => false }

set :user, "yartrans"
set :use_sudo, false
set :deploy_via, :copy
set :deploy_to, "/home/yartrans/yartrans"

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

after "deploy", "rvm:trust_rvmrc"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end