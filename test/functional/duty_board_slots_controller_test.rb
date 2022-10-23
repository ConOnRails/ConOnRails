# frozen_string_literal: true

require 'test_helper'

class DutyBoardSlotsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryBot.create :user
    @user.roles << FactoryBot.create(:admin_duty_board_role)
    @user.roles << FactoryBot.create(:assign_duty_board_role)
    @user_session = { user_id: @user.id, current_role_name: @user.roles.first.name }
    @duty_board_group = FactoryBot.create :blue_man_group
    @duty_board_slot = FactoryBot.build :valid_duty_board_slot
    FactoryBot.create :valid_volunteer
    @duty_board_assignment_attributes = {
      name: Faker::Name.name,
      duty_board_slot_id: @duty_board_slot.id,
      notes: Faker::Lorem.sentence
    }
  end

  test 'should get index' do
    get :index, session: @user_session
    assert_response :success
    assert_not_nil assigns(:duty_board_slots)
  end

  test 'should get new' do
    get :new, session: @user_session
    assert_response :success
  end

  test 'should create duty_board_slot' do
    assert_difference('DutyBoardSlot.count') do
      post :create, params: { duty_board_slot: FactoryBot.attributes_for(:valid_duty_board_slot,
                                                                         duty_board_group_id: @duty_board_group.id) }, session: @user_session
    end

    assert_redirected_to duty_board_slots_path
  end

  test 'should show duty_board_slot' do
    @duty_board_slot.save!
    get :show, params: { id: @duty_board_slot.to_param }, session: @user_session
    assert_response :success
  end

  test 'should get edit' do
    @duty_board_slot.save!
    get :edit, params: { id: @duty_board_slot.to_param }, session: @user_session
    assert_response :success
  end

  test 'should update duty_board_slot' do
    @duty_board_slot.save!
    put :update, params: { id: @duty_board_slot.to_param,
                           duty_board_slot: FactoryBot.attributes_for(:valid_duty_board_slot) }, session: @user_session
    assert_redirected_to duty_board_slots_path
  end

  test 'should destroy duty_board_slot' do
    @duty_board_slot.save!
    assert_difference('DutyBoardSlot.count', -1) do
      delete :destroy, params: { id: @duty_board_slot.to_param }, session: @user_session
    end

    assert_redirected_to duty_board_slots_path
  end
end
