# frozen_string_literal: true

require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  include EventsHelper

  setup do
    FactoryBot.create :ordinary_event
    FactoryBot.create :ordinary_event, secure: true
  end

  user_context :typical_context do
    context '#active_count' do
      should 'return 1 non-secure event' do
        assert_equal 1, active_count
      end
    end

    context '#secure_count' do
      setup do
        expects(:current_user).returns(@user)
      end

      should 'return 0 because we are not cool enough' do
        assert_equal 0, secure_count
      end
    end
  end

  user_context :admin_context do
    context '#active_count' do
      should 'return 1 events' do
        assert_equal 1, active_count
      end
    end

    context '#secure_count' do
      setup do
        expects(:current_user).returns(@admin)
      end

      should 'return 1 event' do
        assert_equal 1, secure_count
      end
    end
  end
end
