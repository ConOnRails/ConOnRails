require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest  
  fixtures :all
  
  setup do
    @user_params = { name: "zog", realname: "zogfrog", password: "zogity", password_confirmation: "zogity" }
    @role_params = { name: "nonpeon", write_entries: true }
    @user = User.create! @user_params
    @role = Role.create @role_params
    @user.roles << @role
    @user.save!
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
    get_root_not_logged_in
    log_in @login_params do |sess|
      sess.get lost_and_found_url
      assert_response :success
      assert_template "lost_and_found/index"
    end
  end
   
   test "log in and go to event log" do
     get_root_not_logged_in
     log_in @login_params do |sess|
       sess.get events_url
       assert_response :success
       assert_template "events/index"
      end
    end 
end
