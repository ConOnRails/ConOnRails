ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def get_root_not_logged_in
    get root_url
    assert_redirected_to public_url
    follow_redirect!
    assert_response :success
    assert_template "sessions/new"
  end
  
  def log_in( login_params )
    sess = open_session
    sess.post sessions_url, login_params
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
    assert_template "con_on_rails/index"    
    yield sess if block_given?
  end
end
