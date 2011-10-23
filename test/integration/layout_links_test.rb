require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest  
  fixtures :all
  
  setup do
    @user_params = { name: "zog", realname: "zogfrog", password: "zogity", password_confirmation: "zogity" }
    @user = User.create! @user_params
    @login_params = { name: @user.name, password: @user.password }
  end
  
  @@title_prefix = 'Con On Rails | '

  test "get main page while not logged in" do
    get_root_not_logged_in
  end
  
  test "get main page then log in" do
    get_root_not_logged_in
    log_in @login_params
  end
  
  test "login and initiate new event" do
    get_root_not_logged_in
    log_in @login_params do |sess|
      sess.get new_event_url
      assert_response :success
      assert_template "events/new"
    end
  end

  test "log_in and go to lost and found" do
    flunk "Lost and Found not implemented yet"
  end
  #do
   # get_root_not_logged_in
    #log_in @login_params do |sess|
    #  sess.get lostfound_url
     # assert_response :success
      #assert_template "lostfound/index"
    #end
  #end
   
   test "log in and go to event log" do
     get_root_not_logged_in
     log_in @login_params do |sess|
       sess.get events_url
       assert_response :success
       assert_template "events/index"
      end
    end 
end
