require 'test_helper'

class EventTypeTest < ActiveSupport::TestCase  
  setup do
    @input_attributes = { name: "Goombah" }
  end
  
  test "attributes should not be empty" do
    et = EventType.new
    assert et.invalid?
    assert et.errors[:name].any?
  end
  
  test "can create an event type" do
    EventType.create!(@input_attributes)
  end
  
  test "event type should be unique" do
    et1 = EventType.create!(@input_attributes)
    et2 = EventType.create(@input_attributes)
    assert et2.invalid?, "This should not happen"
    assert et2.errors[:name].any?
  end
end
