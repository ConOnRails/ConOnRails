source 'http://rubygems.org'
ruby '2.5.5'

gem 'rails', '~>4.2.0'

gem 'pg', '~> 0.18.1'

gem 'puma'
gem 'rails_12factor', group: :production

gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
gem 'coffee-rails', '~> 4.1.0'
gem 'rails-assets-sweetalert2', source: 'https://rails-assets.org'
gem 'rails-sweetalert2-confirm'
gem 'sass-rails', '~> 5.0.1'
gem 'uglifier', '~> 2.7.0'

gem 'acts-as-taggable-on', '~> 4.0'
gem 'bcrypt', '~> 3.1.5'
gem 'bootstrap-sass', '~> 3.4.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.0.0'
gem 'countries', '~> 0.9.3'
gem 'country_select', '~> 2.1.1'
gem 'formtastic', '~> 3.1.3'
gem 'jbuilder', '~> 2.2.8'
gem 'jquery-rails', '~> 4.0.3'
gem 'jquery-ui-rails', '~> 5.0.3'
gem 'kaminari', '~> 0.16.3'
gem 'momentjs-rails', '>= 2.8.1'
gem 'paper_trail', '>= 4.0.0.beta1'
gem 'paper_trail-association_tracking'
gem 'pg_search', '~> 0.7.9'
gem 'ransack', '~> 1.6.3'
gem 'redcarpet', '~> 3.2.2'
gem 'responders', '~> 2.1.0'
gem 'sass', '~> 3.4.12'
gem 'select2-rails'
gem 'simple_form', '~> 3.5.0'
gem 'slim', '~> 3.0.2'
gem 'squeel', '~> 1.2.3'
gem 'sshkit', '~> 1.6.1'
gem 'therubyracer', '~>0.12', require: 'v8'
gem 'yaml_db', '~> 0.3.0'

# Moved to production because we use them in seeds and we need to be able to seed Heroku
gem 'factory_bot_rails', '~> 4.11.0'
gem 'faker'

gem 'derailed'

gem 'flamegraph'
gem 'memory_profiler'
gem 'rack-mini-profiler'
gem 'stackprof' # ruby 2.1+ only

group :development do
  gem 'annotate'
  gem 'rb-fsevent' # , '~> 0.9.1'
  # gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git', :require => 'rails_development_boost'
  # gem 'ruby-debug19', :require => 'ruby-debug'
end

group :development, :test do
  gem 'awesome_print'
  gem 'jasmine'
  gem 'rspec-rails'
  # gem 'minitest'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'minitest-reporters'
  gem 'mocha', require: false
  gem 'selenium-webdriver', '2.53.4'
  gem 'shoulda'
  gem 'shoulda-matchers', '~> 2.0'
  gem 'timecop'
  # gem 'turn'

  gem "codeclimate-test-reporter", '< 1.0', require: nil
  gem 'simplecov'
  gem 'simplecov-html'
end
