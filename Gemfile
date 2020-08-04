# frozen_string_literal: true

source 'http://rubygems.org'
ruby '2.6.5'

gem 'rails', '>= 5.2.0', '< 6.0'
gem 'bootsnap'
gem 'pg', '~> 1.0'

gem 'puma'
gem 'rails_12factor', group: :production

gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
gem 'coffee-rails'
gem 'rails-assets-sweetalert2', '~> 5.1.1', source: 'https://rails-assets.org'
gem 'sass-rails'
gem 'sweet-alert2-rails'
gem 'uglifier'

gem 'acts-as-taggable-on', '~> 6.0'
gem 'bcrypt', '~> 3.1.5'
gem 'bootstrap-sass', '~> 3.4.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.0.0'
gem 'countries'#, '~> 0.9.3'
gem 'country_select'#, '~> 2.1.1'
gem 'formtastic' # , '~> 3.1.3'
gem 'jbuilder'
gem 'jquery-rails', '~> 4.3.3'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'kaminari', '~> 1.2.1'
gem 'momentjs-rails', '>= 2.8.1'
gem 'paper_trail' # , '>= 4.0.0.beta1'
gem 'paper_trail-association_tracking'
gem 'pg_search' # , '~> 0.7.9'
gem 'pundit', '~> 2.1.0'
gem 'ransack' # , '~> 2.3.0'
gem 'redcarpet', '~> 3.2.2'
gem 'responders'
gem 'sassc', '~> 2.0.0' # Breaks above this version.
gem 'select2-rails'
gem 'simple_form'
gem 'slim'
gem 'sshkit' # , '~> 1.6.1'
gem 'therubyracer', require: 'v8'
gem 'yaml_db'

# Moved to production because we use them in seeds and we need to be able to seed Heroku
gem 'factory_bot_rails', '~> 5.0.0'
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
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'jasmine'
  gem 'minitest'
  gem 'minitest-fail-fast'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'minitest-reporters'
  gem 'mocha', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-context'
  gem 'shoulda-matchers', '~> 2.0'
  gem 'timecop'
  # gem 'turn'

  gem 'codeclimate-test-reporter', '< 1.0', require: nil
  gem 'simplecov'
  gem 'simplecov-html'
end
