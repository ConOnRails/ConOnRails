require 'test_helper'

class EventSectionsControllerTest < ActionController::TestCase
  context 'Event sections' do
    setup do
      @section1 = create :section
      @section2 = create :section

      @event1 = create :event
      @event2 = create :event

      @section1.events << @event1
      @section2.events << @event2
    end

    user_context :typical_context do
      setup do
        @section1.users << @user
      end

      should "should get index" do
        get :index
        assert_response :success
        assert_equal assigns(:event_sections), @section1.event_sections
      end

      should "should get show" do
        get :show
        assert_response :success
      end
    end
  end
end
