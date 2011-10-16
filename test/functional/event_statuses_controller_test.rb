require 'test_helper'

class EventStatusesControllerTest < ActionController::TestCase
  setup do
    @event_status = event_statuses(:one)
    @input_attributes = { name: "Fishbait" }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_status" do
    assert_difference('EventStatus.count') do
      post :create, event_status: @input_attributes
    end

    assert_redirected_to event_status_path(assigns(:event_status))
  end

  test "should show event_status" do
    get :show, id: @event_status.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_status.to_param
    assert_response :success
  end

  test "should update event_status" do
    put :update, id: @event_status.to_param, event_status: @input_attributes
    assert_redirected_to event_status_path(assigns(:event_status))
  end

  test "should destroy event_status" do
    assert_difference('EventStatus.count', -1) do
      delete :destroy, id: @event_status.to_param
    end

    assert_redirected_to event_statuses_path
  end
end
