require 'test_helper'

class EventSectionTest < ActiveSupport::TestCase
  should belong_to(:event).inverse_of :event_sections
  should belong_to(:section).inverse_of :event_sections
end
