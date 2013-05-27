source 'http://rubygems.org'

gem 'rails', '~>3.2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '~>1.3'
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'   #, "~> 3.2.3"
  gem 'coffee-rails' #, "~> 3.2.1"
  gem 'uglifier' #, ">= 1.0.3"
end

gem 'audited-activerecord', '~>3.0'
gem 'bcrypt-ruby', '~>3.0'
gem 'capistrano', '~>2.14'
gem 'country-select', '~>1.1'
gem 'formtastic', '~>2.2'
gem 'jquery-rails', '~>2.1'
gem 'jquery-ui-rails', '~>3.0'
gem 'kaminari', '~>0.14'
gem 'ransack'
gem 'libv8', '=3.11.8.13'
gem 'pg_search'
gem 'redcarpet', '~>2.2'
gem 'rvm-capistrano', '~>1.2'
gem 'squeel', '~>1.0'
gem 'therubyracer', '~>0.11', require: 'v8'
gem 'yaml_db', '~>0.2'

group :development do
  gem 'annotate'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git', :require => 'rails_development_boost'
  #gem 'ruby-debug19', :require => 'ruby-debug'
end

# Use unicorn as the web server
# gem 'unicorn'

group :development, :test do
  gem 'minitest'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'minitest-reporters'
  gem 'shoulda'

  #gem 'turn'

  #
  #  gem 'simplecov'
  #  gem 'simplecov-html'
end
