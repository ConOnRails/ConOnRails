# == Schema Information
#
# Table name: 2012
#
#  ATTENDEE_ID         :integer
#  FIRST_NAME          :string(50)
#  MIDDLE_NAME         :string(50)
#  LAST_NAME           :string(50)
#  COMMENTS            :string(50)
#  EMAIL               :string(255)
#  HOME_PHONE          :string(15)
#  WORK_PHONE          :string(15)
#  OTHER_PHONE         :string(15)
#  ADDRESS_LINE_1      :string(75)
#  ADDRESS_LINE_2      :string(50)
#  ADDRESS_LINE_3      :string(50)
#  ADDRESS_CITY        :string(50)
#  ADDRESS_STATE_CODE  :string(2)
#  ADDRESS_ZIP         :string(20)
#  FOREIGN_POSTAL_CODE :string(12)
#  COUNTRY_CODE        :string(3)
#  BADGE_NUMBER        :integer
#  BADGE_NAME          :string(32)
#

require 'test_helper'

class AttendeeTest < ActiveSupport::TestCase
=begin
  setup do
    @attendee = FactoryGirl.build(:attendee)
  end

  test "can get composite name" do
    assert_equal @attendee.FIRST_NAME + ' ' +
      ( @attendee.MIDDLE_NAME.blank? ? '' : @attendee.MIDDLE_NAME + ' ' ) +
      @attendee.LAST_NAME, @attendee.name
  end
=end
end
