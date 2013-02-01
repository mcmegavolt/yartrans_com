load "deploy/assets"

require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano'# Для работы bundler. При изменении гемов bundler автоматически обновит все гемы на сервере, чтобы они в точности соответствовали гемам разработчика.


set :application, "yartrans"
set :rails_env, "production"
set :using_rvm, true
set :rvm_type, :system
set :user, "root"
set :user_rails, "root"
set :rvm_install_with_sudo, true

set :deploy_to, "/srv/#{application}"
set :deploy_via, :copy
set :normalize_asset_timestamps, false

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :scm, :git
set :repository, ".git"
set :branch, "master"

server "91.223.223.135", :web, :app, :db, :primary => true

set :keep_releases, 4

# Fix log/ and pids/ permissions
after "deploy:setup", "deploy:fix_setup_permissions"

# Fix permissions
before "deploy:start", "deploy:fix_permissions"
after "deploy:restart", "deploy:fix_permissions"
after "assetsrecompile", "deploy:fix_permissions"


      after 'deploy:update_code', :roles => :app do
  # Здесь для примера вставлен только один конфиг с приватными данными - database.yml. Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда. При каждом деплое создаются ссылки на них в нужные места приложения.
  run "rm -f #{current_release}/config/database.yml"
  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
end

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

task :fix_setup_permissions, :roles => :app, :except => { :no_release => true } do
  run "#{sudo} chgrp #{user_rails} #{shared_path}/log"
  run "#{sudo} chgrp #{user_rails} #{shared_path}/pids"
end

task :fix_permissions, :roles => :app, :except => { :no_release => true } do
  # To prevent access errors while moving/deleting
  run "#{sudo} chmod 775 #{current_path}/log"
  run "#{sudo} find #{current_path}/log/ -type f -exec chmod 664 {} \\;"
  run "#{sudo} find #{current_path}/log/ -exec chown #{user}:#{user_rails} {} \\;"
  run "#{sudo} find #{current_path}/tmp/ -type f -exec chmod 664 {} \\;"
  run "#{sudo} find #{current_path}/tmp/ -type d -exec chmod 775 {} \\;"
  run "#{sudo} find #{current_path}/tmp/ -exec chown #{user}:#{user_rails} {} \\;"
end