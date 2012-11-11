require 'test_helper'

class DutyBoardGroupsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :admin_duty_board_role
    @user.roles << @role
    @user_session     = { user_id: @user.id, current_role: @role.name }
    @duty_board_group = FactoryGirl.build :valid_duty_board_group
  end

  test "get index" do
    get :index, { }, @user_session
    assert_response :success
  end

  test "get new" do
    get :new, { }, @user_session
    assert_response :success
  end

  test 'post create' do
    assert_difference 'DutyBoardGroup.count' do
      post :create, { duty_board_group: FactoryGirl.attributes_for(:valid_duty_board_group) }, @user_session
    end
    assert_redirected_to duty_board_groups_path
  end

  test "get edit" do
    @duty_board_group.save!
    get :edit, { id: @duty_board_group.to_param }, @user_session
    assert_response :success
  end

  test "put update" do
    @duty_board_group.save!
    put :update, { id: @duty_board_group.id, duty_board_group: FactoryGirl.attributes_for(:valid_duty_board_group) }, @user_session

    assert_redirected_to duty_board_groups_path
  end

  test "delete" do
    @duty_board_group.save!
    assert_difference 'DutyBoardGroup.count', -1 do
      delete :destroy, { id: @duty_board_group.to_param }, @user_session
    end
    assert_redirected_to duty_board_groups_path
  end
end
