require 'test_helper'

class EventSectionTest < ActiveSupport::TestCase
  should belong_to :event
  should belong_to :section
end
