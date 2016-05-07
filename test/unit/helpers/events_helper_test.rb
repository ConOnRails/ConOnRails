require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  include EventsHelper

  setup do
    FactoryGirl.create :ordinary_event
  end

  user_context :typical_context do
     context '#get_active_count' do
      should 'return 1 non-secure event' do
        assert_equal 1, get_active_count
      end
    end
  end

  user_context :admin_context do
    context '#get_active_count' do
      should 'return 1 events' do
        assert_equal 1, get_active_count
      end
    end
  end
end
