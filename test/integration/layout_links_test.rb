require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest
  fixtures :all

  @@title_prefix = 'Con On Rails | '

  test "should get main" do
    get "/"
    assert_response :success
    assert_select 'title', @@title_prefix + 'Main'
  end
  
  test "should get event review" do
    get "/events"
    assert_response :success
    assert_select 'title', @@title_prefix + 'Event Log'
  end
  
  test "should get lost/found items" #do
#    get "/lostfound"
#    assert_response :success
#    assert_select 'title', @@title_prefix + "Lost Items"
#  end
  
  test "should get messages"  #do
#    get "/messages"
#    assert_response :success
#    assert_select 'title', @@title_prefix + "Messages"
#  end
  
  test "should get equipment" #do
#    get "/equipment"
#    assert_resopnse :success
#    assert_select 'title', @@title_prefix + "Equipment"
#  end
  
  test "should be able to sign in" do
    get "/signin"
    assert_response :success
    assert_select 'title', @@title_prefix + "Mr X., Sign in please!"
  end
  
  test "should be able to sign out" do
    get "/signout"
    assert_redirected_to root_url
  end
end
