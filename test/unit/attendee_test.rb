require 'test_helper'

class AttendeeTest < ActiveSupport::TestCase
  setup do
    @attendee = FactoryGirl.build(:attendee)
  end

  test "can get composite name" do
    assert_equal @attendee.FIRST_NAME + ' ' +
      ( @attendee.MIDDLE_NAME.blank? ? '' : @attendee.MIDDLE_NAME + ' ' ) +
      @attendee.LAST_NAME, @attendee.name
  end

end
