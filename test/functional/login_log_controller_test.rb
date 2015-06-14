require 'test_helper'

class LoginLogControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :read_audits_role
    @user.roles << @role
    @user_session = { user_id: @user.id, current_role_name: @role.name }
  end

  test "should get index" do
    get :index, {}, @user_session
    assert_response :success
  end

end
