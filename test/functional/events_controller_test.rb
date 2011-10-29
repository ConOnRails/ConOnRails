require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
    #@event.entry = entries(:verbosity)
    @user  = users(:one)
  end

  test "should get index" do
    get :index, {}, { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new, { user_id: @user.id }, { user_id: @user.id }
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, { event: @event.attributes, entry: entries( :verbosity ).attributes }, { user_id: @user.id }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, { id: @event.to_param, user_id: @user.id }, { user_id: @user.id }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: @event.to_param, user_id: @user.id }, { user_id: @user.id }
    assert_response :success
  end

  test "should update event" do
    put :update, { id: @event.to_param, event: @event.attributes, entry: entries( :verbosity ).attributes }, { user_id: @user.id }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should update event with no additional entry" do
    put :update, { id: @event.to_param, event: @event.attributes, entry: { description: '' } }, { user_id: @user.id } 
    assert_redirected_to event_path(assigns(:event))
  end
  
  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, { id: @event.to_param }, { user_id: @user.id }
    end

    assert_redirected_to events_path
  end
end
