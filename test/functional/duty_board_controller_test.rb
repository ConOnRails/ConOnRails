require 'test_helper'

class DutyBoardControllerTest < ActionController::TestCase
  setup do
    @dbs = FactoryGirl.create :valid_duty_board_slot
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :assign_duty_board_role
    @user.roles << @role
    @user_session = { user_id: @user.id, current_role: @role.name }
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "peon cannot assign" do
    get :assign_slot, id: @dbs.to_param
    assert_redirected_to :public
  end

  test "get assignment form" do
    get :assign_slot, { id: @dbs.to_param }, @user_session
  end
end
