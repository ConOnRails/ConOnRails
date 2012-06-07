require 'test_helper'

class DutyBoardSlotsControllerTest < ActionController::TestCase
  setup do
    @duty_board_slot = duty_board_slots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:duty_board_slots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create duty_board_slot" do
    assert_difference('DutyBoardSlot.count') do
      post :create, duty_board_slot: @duty_board_slot.attributes
    end

    assert_redirected_to duty_board_slot_path(assigns(:duty_board_slot))
  end

  test "should show duty_board_slot" do
    get :show, id: @duty_board_slot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @duty_board_slot.to_param
    assert_response :success
  end

  test "should update duty_board_slot" do
    put :update, id: @duty_board_slot.to_param, duty_board_slot: @duty_board_slot.attributes
    assert_redirected_to duty_board_slot_path(assigns(:duty_board_slot))
  end

  test "should destroy duty_board_slot" do
    assert_difference('DutyBoardSlot.count', -1) do
      delete :destroy, id: @duty_board_slot.to_param
    end

    assert_redirected_to duty_board_slots_path
  end
end
