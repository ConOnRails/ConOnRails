require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    @my_entry = entries(:verbosity)
    @user  = users(:one)
    @event = events(:one)
  end

  test "should get index" do
    get :index, { event_id: @event.id }, { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should get new" do
    get :new, { event_id: @event.id }, { user_id: @user.id }
    assert_response :success
  end

  test "should create entry" do
    assert_difference('Entry.count') do
      post :create, { event_id: @event.id, entry: @my_entry.attributes }, { user_id: @user.id }
    end

    assert_redirected_to entry_path(assigns(:entry))
  end
end
