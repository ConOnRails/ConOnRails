require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryGirl.create(:user)
    @role = FactoryGirl.create(:write_entries_role)
    @user.roles << @role
    @user.save!
    @login_params = { username: @user.username, password: @user.password }
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
