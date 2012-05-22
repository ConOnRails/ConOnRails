require 'test_helper'

class RadioAssignmentAuditsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :admin_radios_role
    @user.roles << @role
  end

  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:radio_assignment_audits)
  end


end
