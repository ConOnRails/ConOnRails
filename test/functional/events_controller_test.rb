require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @entry        = entries :oneliner
    @verb_entry   = entries :verbosity
    @event        = events :one
    @event.entries << @entry
    @hidden_event = events :hidden
    @hidden_event.entries << @verb_entry
    @user         = users :one
    @admin_role   = roles :admin
    @user.roles << @admin_role
    @peon_user    = users :two
  end

  test "any user can get index" do
    get :index, { }, { user_id: @peon_user.id }
    assert_response :success
    assert_not_nil assigns :events
    assert_not_equal 0, assigns["events"].count
  end

  test "peon user should get index without hidden" do
    get :index, { }, { user_id: @peon_user.id }
    assert_response :success
    assert_not_nil assigns(:events)
    assert_equal 2, assigns["events"].count
  end
  
  test "non-peon should get index with hidden" do
    get :index, { }, { user_id: @user.id }
    assert_response :success
    assert_not_nil assigns(:events)
    assert_equal 3, assigns["events"].count
  end
  
  test "should get new" do
    get :new, { }, { user_id: @user.id }
    assert_response :success
  end

  test "peon user cannot get new" do
    get :new, { }, { user_id: @peon_user.id }
    assert_redirected_to events_url
  end
    
  test "should create event" do
    assert_difference('Event.count') do
      post :create, { event: @event.attributes, entry: entries( :verbosity ).attributes }, { user_id: @user.id }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "peon user cannot create event" do
    assert_no_difference( 'Event.count' ) do
      post :create, { event: @event.attributes, entry: entries( :verbosity ).attributes }, { user_id: @peon_user.id }
    end
  end

  test "should show event" do
    get :show, { id: @event.to_param }, { user_id: @user.id }
    assert_response :success
  end

  test "peon user can show event" do
    get :show, { id: @event.to_param }, { user_id: @peon_user.id }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: @event.to_param }, { user_id: @user.id }
    assert_response :success
  end
  
  test "peon user cannot edit" do
    get :edit, { id: @event.to_param  }, { user_id: @peon_user.id }
    assert_redirected_to events_url
  end
  
  test "should update event" do
    put :update, { id: @event.to_param, event: @event.attributes, entry: entries( :verbosity ).attributes }, { user_id: @user.id }
    assert_redirected_to event_path(assigns(:event))
  end
  
  test "peon user cannot update event" do
    put :update, { id: @event.to_param, event: @event.attributes, entry: entries( :verbosity ).attributes }, { user_id: @peon_user.id }
    assert_redirected_to events_url
  end

  test "should update event with no additional entry" do
    put :update, { id: @event.to_param, event: @event.attributes, entry: { description: '' } }, { user_id: @user.id } 
    assert_redirected_to event_path(assigns(:event))
  end
  
  test "creating an event with blank initial entry fails" do
    assert_no_difference 'Event.count' do
      post :create, { event: @event.attributes, entry: { description: '' } }, { user_id: @user.id }
    end
  end
  
  test "creating an event with NO initial entry fails" do
    assert_no_difference 'Event.count' do
      post :create, { event: @event.attributes }, { user_id: @user_id }
    end
  end
  
  test "creating an event while not logged in fails" do
    assert_no_difference 'Event.count' do
      post :create, { event: @event.attributes, entry: entries( :verbosity ).attributes }
    end
  end
end 
