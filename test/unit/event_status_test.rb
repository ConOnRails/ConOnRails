require 'test_helper'

class EventStatusTest < ActiveSupport::TestCase
  setup do
    @input_attributes = { name: "Foom" }
  end
  
  test "attributes should not be empty" do
    es = EventStatus.new
    assert es.invalid?
    assert es.errors[:name].any?
  end
  
  test "can create an event status entry" do
    EventStatus.create!(@input_attributes)
  end
  
  test "event status is unique" do
    es1 = EventStatus.create!(@input_attributes)
    es2 = EventStatus.create(@input_attributes)
    assert es2.invalid?, "This should fail"
    assert es2.errors[:name].any?
  end
  
  
end
