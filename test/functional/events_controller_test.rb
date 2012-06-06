require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event            = FactoryGirl.create :ordinary_event
    @hidden_event     = FactoryGirl.create :hidden_event
    @user             = FactoryGirl.create :user
    @admin_role       = FactoryGirl.create :write_entries_role
    @read_hidden_role = FactoryGirl.create :read_hidden_entries_role
    @user.roles << @admin_role
    @peon_user = FactoryGirl.create :peon
  end

  # We're going to use these in a couple of places to stress test permissions
  def get_index(user)
    get :index, { }, { user_id: user.id }
    assert_response :success
    assert_not_nil assigns :events
    assert_not_equal 0, assigns["events"].count
  end

  test "any user can get index" do
    get_index @peon_user
  end

  test "peon user should get index without hidden" do
    get_index @peon_user
    assert_equal 1, assigns["events"].count
  end

  test "user with show_hidden should get index with hidden" do
    # This is to test not only the specific permission, but also that stacked
    # roles are appropriately additive!
    @user.roles << @read_hidden_role
    @user.save!
    get_index @user
    assert_equal 2, assigns["events"].count
  end

  test "should get new" do
    get :new, { }, { user_id: @user.id }
    assert_response :success
  end

  test "should get new emergency" do
    get :new, { emergency: '1' }, { user_id: @user.id }
    assert_equal true, assigns(:event).emergency
  end

  test "peon user cannot get new" do
    get :new, { }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "should create event" do
    assert_difference('EventFlagHistory.count') do
      assert_difference('Entry.count') do
        assert_difference('Event.count') do
          post :create, { event: FactoryGirl.attributes_for(:ordinary_event),
                          entry: FactoryGirl.attributes_for(:verbose_entry) },
               { user_id: @user.id }
        end
      end
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "peon user cannot create event" do
    assert_no_difference('Event.count') do
      post :create, { event: FactoryGirl.attributes_for(:ordinary_event),
                      entry: FactoryGirl.attributes_for(:verbose_entry) },
           { user_id: @peon_user.id }
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
    get :edit, { id: @event.to_param }, { user_id: @peon_user.id }
    assert_redirected_to :public
  end

  test "should update event" do
    put :update, { id:    @event.to_param, event: FactoryGirl.attributes_for(:ordinary_event),
                   entry: FactoryGirl.attributes_for(:verbose_entry) }, { user_id: @user.id }
    assert_redirected_to event_path(assigns(:event))
  end

  test "peon user cannot update event" do
    put :update, { id:    @event.to_param, event: FactoryGirl.attributes_for(:ordinary_event),
                   entry: FactoryGirl.attributes_for(:verbose_entry) }, { user_id: @peon_user.id }
    assert_redirected_to :public
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
      post :create, { event: FactoryGirl.attributes_for(:ordinary_event) }, { user_id: @user_id }
    end
  end

  test "creating an event while not logged in fails" do
    assert_no_difference 'Event.count' do
      post :create, { event: FactoryGirl.attributes_for(:ordinary_event),
                      entry: FactoryGirl.attributes_for(:verbose_entry) }
    end
  end
end
