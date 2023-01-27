# frozen_string_literal: true

require 'test_helper'

class DutyBoardAssignmentsControllerTest < ActionController::TestCase
  setup do
    @dbs = FactoryBot.create :valid_duty_board_slot
    @user = FactoryBot.create :user
    @role = FactoryBot.create :assign_duty_board_role
    @user.roles << @role
    @user_session = { user_id: @user.id, current_role_name: @role.name }
  end

  test 'peon cannot assign' do
    get :new, params: { duty_board_slot_id: @dbs.to_param }

    assert_redirected_to :public

    get :edit, params: { duty_board_slot_id: @dbs.to_param, id: 1 }

    assert_redirected_to :public

    post :create, params: { duty_board_slot_id: @dbs.to_param,
                            duty_board_assignment: { name: 'Foo' } }

    assert_redirected_to :public

    patch :update, params: { duty_board_slot_id: @dbs.to_param, id: 1,
                             duty_board_assignment: { name: 'Foo' } }

    assert_redirected_to :public

    delete :destroy, params: { duty_board_slot_id: @dbs.to_param, id: 1 }

    assert_redirected_to :public
  end

  test 'get assignment form' do
    get :new, params: { duty_board_slot_id: @dbs.to_param }, session: @user_session

    assert_response :success
  end

  test 'create assignment' do
    post :create, params: { duty_board_slot_id: @dbs.to_param,
                            duty_board_assignment: { name: 'Foo' } }, session: @user_session

    assert_redirected_to duty_board_index_path
  end

  test 'edit assignment' do
    @dbs.create_duty_board_assignment(name: 'Foo')
    get :edit, params: { duty_board_slot_id: @dbs.to_param,
                         id: @dbs.duty_board_assignment.id }, session: @user_session

    assert_response :success
  end

  test 'update assignment' do
    @dbs.create_duty_board_assignment(name: 'Foo')
    patch :update, params: { duty_board_slot_id: @dbs.to_param, id: @dbs.duty_board_assignment.id,
                             duty_board_assignment: { name: 'Bar' } }, session: @user_session

    assert_redirected_to duty_board_index_path
  end

  test 'destroy assignment' do
    @dbs.create_duty_board_assignment(name: 'Foo')
    delete :destroy, params: { duty_board_slot_id: @dbs.to_param,
                               id: @dbs.duty_board_assignment.id }, session: @user_session

    assert_redirected_to duty_board_index_path
  end
end
