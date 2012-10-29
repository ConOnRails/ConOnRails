require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to :user
  should validate_presence_of :for
  should validate_presence_of :message
  should validate_presence_of :user
  should allow_value("444 444 4444").for :phone_number
  should_not allow_value("llama").for :phone_number

end
