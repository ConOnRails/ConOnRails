require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest
  fixtures :all

  @@title_prefix = 'Con On Rails | '

  test "should get main" do
    get "/"
    assert_response :success
    assert_select 'title', @@title_prefix + 'Main'
  end
  
  test "should get events" do
    get "/events"
    assert_response :success
    assert_select 'title', @@title_prefix + 'Event Log'
  end
  
  test "should get lost items" do
    get "/lost_items"
    assert_response :success
    assert_select 'title', @@title_prefix + "Lost Items"
  end
  
  test "should get found items" do
    get "/found_items"
    assert_response :success
    assert_select 'title', @@title_prefix + "Found Items"
  end
  
  test "should get users" do
    get "/users"
    assert_response :success
    assert_select 'title', @@title_prefix + "Users"
  end
  
  test "should be able to sign in" do
    get "/signin"
    assert_response :success
    assert_select 'title', @@title_prefix + "Mr X., Sign in please!"
  end
  
  test "should be able to sign out" do
    get "/signout"
    assert_response :success
    assert_select 'title', @@title_prefix + "Goodbye!"
  end
end
