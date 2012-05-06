require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @bad_message = FactoryGirl.attributes_for :message
    @message = FactoryGirl.attributes_for :valid_message
    @message[:user] = FactoryGirl.create :user
  end

  test "empty messages are dumb" do
    message = Message.create @bad_message
    assert message.invalid?, "Blank messages should fail"
  end

  test "good messages are keen" do
    message = Message.create @message
    assert message.valid?,  "valid messages should work"
  end

  test "bad phone numbers are bad" do
    @message[:phone_number] = "Llama"
    message = Message.create @message
    assert message.invalid?, "phone number must be valid"
  end
end
