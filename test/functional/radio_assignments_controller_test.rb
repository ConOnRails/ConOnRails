require 'test_helper'

class RadioAssignmentsControllerTest < ActionController::TestCase
  setup do
    @radio_assignment = radio_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:radio_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create radio_assignment" do
    assert_difference('RadioAssignment.count') do
      post :create, radio_assignment: @radio_assignment.attributes
    end

    assert_redirected_to radio_assignment_path(assigns(:radio_assignment))
  end

  test "should show radio_assignment" do
    get :show, id: @radio_assignment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @radio_assignment.to_param
    assert_response :success
  end

  test "should update radio_assignment" do
    put :update, id: @radio_assignment.to_param, radio_assignment: @radio_assignment.attributes
    assert_redirected_to radio_assignment_path(assigns(:radio_assignment))
  end

  test "should destroy radio_assignment" do
    assert_difference('RadioAssignment.count', -1) do
      delete :destroy, id: @radio_assignment.to_param
    end

    assert_redirected_to radio_assignments_path
  end
end
