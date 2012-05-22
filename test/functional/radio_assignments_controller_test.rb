require 'test_helper'

class RadioAssignmentsControllerTest < ActionController::TestCase
  setup do
    @radio_assignment = FactoryGirl.build :valid_radio_assignment
    @user = FactoryGirl.create :user
    @role = FactoryGirl.create :assign_radios_role
    @user.roles << @role
    @user_session = { user_id: @user.id }
  end

  test "should get index" do
    get :index, {}, @user_session
    assert_response :success
    assert_not_nil assigns(:radio_assignments)
  end

  test "should get new" do
    get :new, {}, @user_session
    assert_response :success
  end

  test "should create radio_assignment" do
    assert_difference('RadioAssignment.count') do
      post :create, { radio_assignment: @radio_assignment.attributes }, @user_session
    end

    assert_redirected_to radio_assignment_path(assigns(:radio_assignment))
  end

  test "should get edit" do
    @radio_assignment.save!
    get :edit, { id: @radio_assignment.to_param }, @user_session
    assert_response :success
  end

  test "should update radio_assignment" do
    @radio_assignment.save!
    put :update, { id: @radio_assignment.to_param, radio_assignment: @radio_assignment.attributes }, @user_session
    assert_redirected_to radio_assignment_path(assigns(:radio_assignment))
  end

  test "should destroy radio_assignment" do
    @radio_assignment.save!
    assert_difference('RadioAssignment.count', -1) do
      delete :destroy, { id: @radio_assignment.to_param }, @user_session
    end

    assert_redirected_to radio_assignments_path
  end
end
