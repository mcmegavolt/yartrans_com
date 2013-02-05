source 'http://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'haml'
gem 'inherited_resources'
gem 'thin'

gem 'unicorn'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'
  gem 'haml-rails'
end

group :development do
  gem 'sqlite3'
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'capistrano-unicorn', :require => false
end

group :production do
  gem 'mysql2'
end