lock '3.2.1'

set :rails_env, "production" #added for delayed_jobs

set :tmp_dir, "/home/yartranscom/tmp"

set :deploy_to, "/home/yartranscom/yartranscom"
set :scm, :git
set :deploy_via, :remote_cache
set :repo_url, 'git@github.com:mcmegavolt/yartrans_com.git'
set :copy_exclude, [".git"]
set :branch, 'develop'
set :format, :pretty
set :log_level, :debug
set :pty, true

set :rvm_type, :user
set :rvm_ruby_version, '2.1.2'
  
set :linked_dirs, %w{public/uploads}

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    	invoke 'delayed_job:restart'
    end
  end

  after :finishing, 'deploy:cleanup'

end

after 'deploy:publishing', 'deploy:restart'