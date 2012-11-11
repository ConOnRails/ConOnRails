require 'test_helper'

class RadioAssignmentsControllerTest < ActionController::TestCase
  setup do
    @radio_assignment = FactoryGirl.build :valid_radio_assignment
    @user             = FactoryGirl.create :user
    @role             = FactoryGirl.create :assign_radios_role
    @radio            = FactoryGirl.create :valid_blue_radio
    @department       = FactoryGirl.create :good_department
    @user.roles << @role
    @user_session = { user_id: @user.id }
  end

  test "should create radio_assignment" do
    assert_difference('RadioAssignmentAudit.count') do
      assert_difference('RadioAssignment.count') do
        post :create, { radio_assignment: FactoryGirl.attributes_for(:valid_radio_assignment, radio_id: @radio.id, department_id: @department) }, @user_session
      end
    end
    assert_equal "out", assigns(:radio_assignment).radio.state
    assert_redirected_to radios_path
  end

  test "should destroy radio_assignment" do
    radio = @radio_assignment.radio
    radio.state = "out"
    @radio_assignment.save!
    radio_id = radio.id
    assert_difference 'RadioAssignmentAudit.count' do
      assert_difference('RadioAssignment.count', -1) do
        delete :destroy, { id: @radio_assignment.to_param }, @user_session
      end
    end
    assert_equal "in", Radio.find_by_id( radio_id ).state
    assert_redirected_to radios_path
  end
end
