require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  include EventsHelper

  setup do
    FactoryGirl.create :ordinary_event
    FactoryGirl.create :ordinary_event, secure: true
  end

  user_context :typical_context do
     context '#get_active_count' do
      should 'return 1 non-secure event' do
        assert_equal 1, get_active_count
      end
    end

=begin
    context '#get_secure_count' do
      setup do
        self.expects(:current_user).returns(@user)
      end

      should 'return 0 because we are not cool enough' do
        assert_equal 0, get_secure_count
      end
    end
=end
  end

  user_context :admin_context do
    context '#get_active_count' do
      should 'return 1 events' do
        assert_equal 1, get_active_count
      end
    end

    context '#get_secure_count' do
      should 'return 1 event' do
        assert_equal 1, get_secure_count
      end
    end
  end
end
