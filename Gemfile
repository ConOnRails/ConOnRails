# frozen_string_literal: true

source 'http://rubygems.org'
ruby '2.7.6'

gem 'bootsnap'
gem 'pg', '~> 1.4.0'
gem 'rails', '~> 6.1.0'

gem 'puma', '~> 6.0.0'
gem 'rails_12factor', group: :production

gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
gem 'coffee-rails'
gem 'sass-rails'
gem 'uglifier'

gem 'acts-as-taggable-on', '~> 9.0.0'
gem 'bcrypt', '~> 3.1.18'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.0'
gem 'bootstrap-sass', '~> 3.4.0'
gem 'countries', '~> 3.1.0'
gem 'country_select', '~> 5.1.0'
gem 'formtastic', '~> 4.0.0'
gem 'jbuilder', '~> 2.11.0'
gem 'jquery-rails', '~> 4.5.0'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'kaminari', '~> 1.2.2'
gem 'momentjs-rails', '>= 2.8.1'
gem 'paper_trail', '~> 12'
gem 'paper_trail-association_tracking', '~> 2.2.0'
gem 'pg_search', '~> 2.3.6'
gem 'pundit', '~> 2.2.0'
gem 'ransack', '~> 3.0.1'
gem 'redcarpet', '~> 3.5.1'
gem 'responders', '~> 3.0.1'
gem 'sassc', '~> 2.0.0' # Breaks above this version.
gem 'select2-rails', '~> 4.0.3'
gem 'simple_form', '~> 5.1.0'
gem 'slim', '~> 4.1.0'
gem 'sshkit', '~> 1.21.0'
gem 'therubyracer', require: 'v8'
gem 'yaml_db', '~> 0.7.0'

# Moved to production because we use them in seeds and we need to be able to seed Heroku
gem 'factory_bot_rails', '~> 6.2.0'
gem 'faker', '~> 2.22.0'

gem 'derailed', '~> 0.1.0'

gem 'flamegraph'
gem 'memory_profiler'
gem 'rack-mini-profiler'
gem 'stackprof' # ruby 2.1+ only

group :development do
  gem 'annotate'
  gem 'listen'
  gem 'next_rails'
  gem 'rb-fsevent' # , '~> 0.9.1'
end

group :development, :test do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'minitest'
  gem 'minitest-fail-fast'
  gem 'rails-controller-testing'
  gem 'rubocop', require: false
  gem 'rubocop-minitest'
  gem 'rubocop-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.8.0'
  gem 'minitest-reporters'
  gem 'mocha', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-context'
  gem 'shoulda-matchers', '~> 5'
  gem 'timecop'
  # gem 'turn'

  gem 'codeclimate-test-reporter', '< 1.0', require: nil
  gem 'simplecov'
  gem 'simplecov-html'
end
