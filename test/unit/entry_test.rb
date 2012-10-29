require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  should belong_to :event
  should belong_to :user
  should validate_presence_of :description
  should validate_presence_of :user
  should validate_presence_of :event
end
