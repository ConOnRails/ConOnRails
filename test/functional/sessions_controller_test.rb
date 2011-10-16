require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should have the right title" do
    get :new
    assert_select 'title', "Con On Rails | Mr X., Sign in please!"
  end
end
