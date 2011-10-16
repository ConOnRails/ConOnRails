require 'test_helper'

class EventTest < ActiveSupport::TestCase
    fixtures :events, :event_types, :event_statuses

    test "event attributes must not be empty" do
        event = Event.new
        assert event.invalid?
        assert event.errors[:summary].any?
        assert event.errors[:event_status_id].any?
        assert event.errors[:event_type_id].any?
    end
end
