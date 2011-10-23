require 'test_helper'

class EventTest < ActiveSupport::TestCase
    fixtures :events
    
    test "event attributes must not be empty" do
        event = Event.new
        assert event.invalid?
        assert event.errors[:summary].any?
    end
end
