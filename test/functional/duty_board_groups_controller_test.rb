# frozen_string_literal: true

require 'test_helper'

class DutyBoardGroupsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryBot.create :user
    @role = FactoryBot.create :admin_duty_board_role
    @user.roles << @role
    @user_session = { user_id: @user.id, current_role_name: @role.name }
    @duty_board_group = FactoryBot.build :valid_duty_board_group
  end

  test 'get index' do
    get :index, session: @user_session
    assert_response :success
  end

  test 'get new' do
    get :new, session: @user_session
    assert_response :success
  end

  test 'post create' do
    assert_difference 'DutyBoardGroup.count' do
      post :create, params: { duty_board_group: FactoryBot.attributes_for(:valid_duty_board_group) }, session: @user_session
    end
    assert_redirected_to duty_board_groups_path
  end

  test 'get edit' do
    @duty_board_group.save!
    get :edit, params: { id: @duty_board_group.to_param }, session: @user_session
    assert_response :success
  end

  test 'put update' do
    @duty_board_group.save!
    put :update, params: { id: @duty_board_group.id,
                           duty_board_group: FactoryBot.attributes_for(:valid_duty_board_group) }, session: @user_session

    assert_redirected_to duty_board_groups_path
  end

  test 'delete' do
    @duty_board_group.save!
    assert_difference 'DutyBoardGroup.count', -1 do
      delete :destroy, params: { id: @duty_board_group.to_param }, session: @user_session
    end
    assert_redirected_to duty_board_groups_path
  end
end
