require 'test_helper'

class DutyBoardSlotsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :admin_duty_board_role
    @user.roles << @role
    @user_session                     = { user_id: @user.id, current_role: @role.name }
    @duty_board_slot                  = FactoryGirl.build :valid_duty_board_slot
    vol                               = FactoryGirl.create :valid_volunteer
    @duty_board_assignment_attributes = {
        name:               Faker::Name.name,
        duty_board_slot_id: @duty_board_slot.id,
        notes:              Faker::Lorem.sentence
    }

  end

  test "should get index" do
    get :index, { }, @user_session
    assert_response :success
    assert_not_nil assigns(:duty_board_slots)
  end

  test "should get new" do
    get :new, { }, @user_session
    assert_response :success
  end

  test "should create duty_board_slot" do
    assert_difference('DutyBoardSlot.count') do
      post :create, { duty_board_slot: @duty_board_slot.attributes }, @user_session
    end

    assert_redirected_to duty_board_slots_path
  end

  test "should show duty_board_slot" do
    @duty_board_slot.save!
    get :show, { id: @duty_board_slot.to_param }, @user_session
    assert_response :success
  end

  test "should get edit" do
    @duty_board_slot.save!
    get :edit, { id: @duty_board_slot.to_param }, @user_session
    assert_response :success
  end

  test "should update duty_board_slot" do
    @duty_board_slot.save!
    put :update, { id: @duty_board_slot.to_param, duty_board_slot: @duty_board_slot.attributes },
        @user_session
    assert_redirected_to duty_board_slot_path(assigns(:duty_board_slot))
  end

  test "should update empty duty board slot with duty board assignment" do
    @duty_board_slot.save!

    put :update, { id:                    @duty_board_slot.to_param,
                   duty_board_slot:       @duty_board_slot.attributes,
                   duty_board_assignment: @duty_board_assignment_attributes },
        @user_session
    assert_redirected_to duty_board_index_path
    assert_equal @duty_board_assignment_attributes[:name],
                 assigns(:duty_board_slot).duty_board_assignment.name
  end

  test "can update duty board slot with new information" do
    @duty_board_slot.build_duty_board_assignment @duty_board_assignment_attributes
    @duty_board_slot.save!

    put :update, { id:                    @duty_board_slot.to_param,
                   duty_board_slot:       @duty_board_slot.attributes,
                   duty_board_assignment: { notes: "Yak" } },
        @user_session
    assert_redirected_to duty_board_index_path
    assert_equal "Yak", assigns(:duty_board_slot).duty_board_assignment.notes
  end

  test "can clear assignment" do
    @duty_board_slot.save!
    @duty_board_slot.build_duty_board_assignment @duty_board_assignment_attributes

    post :clear_assignment, { id: @duty_board_slot.to_param }, @user_session
    assert_redirected_to duty_board_index_path
    assert_nil assigns(:duty_board_slot).duty_board_assignment
  end

  test "should destroy duty_board_slot" do
    @duty_board_slot.save!
    assert_difference('DutyBoardSlot.count', -1) do
      delete :destroy, { id: @duty_board_slot.to_param }, @user_session
    end

    assert_redirected_to duty_board_slots_path
  end
end
