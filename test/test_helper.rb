require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'
require 'minitest/reporters'
require 'capybara/rails'

MiniTest::Reporters.use! #[MiniTest::Reporters::ProgressReporter.new]


class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  self.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :transaction

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end


  # Add more helper methods to be used by all tests here...
  def get_root_not_logged_in
    get root_url
    assert_redirected_to public_url
    follow_redirect!
    assert_response :success
    assert_template "sessions/new"
  end

  def log_in(login_params)
    sess = open_session
    sess.post sessions_url, login_params
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
    assert_template "events/index"
    yield sess if block_given?
  end

  def sign_in(user, role)
    session[:user_id]      = user.id
    session[:current_role_name] = role.name
  end

  def admin_context
    @admin      = FactoryGirl.create :user
    @admin_role = FactoryGirl.create :superuser_role
    @admin.roles << @admin_role
    @admin.save!

    sign_in @admin, @admin_role
  end

  def typical_context
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :typical_role
    @user.roles << @role
    @user.save!

    sign_in @user, @role
  end

  def peon_context
    sign_in FactoryGirl.create(:user), FactoryGirl.create(:role)
  end

  def self.multiple_contexts(*contexts, &blk)
    contexts.each do |context|
      self.user_context context, &blk
    end
  end

  def self.user_context(context, &blk)
    context "as #{context}" do
      setup do
        send context if respond_to? context
      end

      merge_block &blk
    end
  end
end

class ActionDispatch::IntegrationTest 
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  def setup
    Capybara.run_server = true
    Capybara.server_port = 3000
  end


  # Switch to JavaScript Driver
  def jsDriver
    Capybara.current_driver = Capybara.javascript_driver
    yield
    Capybara.current_driver = Capybara.default_driver
  end

  def sign_in(user, role)
    session[:user_id]      = user.id
    session[:current_role_name] = role.name
  end

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

require 'mocha/setup'
