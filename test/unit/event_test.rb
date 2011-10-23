require 'test_helper'

class EventTest < ActiveSupport::TestCase
    fixtures :events
    
    test "active flag should be true by default" do
      event = Event.new
      assert event.is_active?
    end
    
    test "type flags should be false by default" do
      event = Event.new
      assert !event.comment?
      assert !event.flagged?
      assert !event.post_con?
      assert !event.quote?
      assert !event.sticky?
      assert !event.emergency?
      assert !event.medical?
      assert !event.hidden?
      assert !event.secure?
    end
    
    test "department flags should be false by default" do
      event = Event.new
      assert !event.consuite?
      assert !event.hotel?
      assert !event.parties?
      assert !event.volunteers?
      assert !event.dealers?
      assert !event.dock?
      assert !event.merchandise?
    end
end
