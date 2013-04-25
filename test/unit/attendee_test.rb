require 'test_helper'

class AttendeeTest < ActiveSupport::TestCase
  setup do
#    Attendee.all.each() do |a|
#     print "#{a.FIRST_NAME}\n"
#    end
  end

  test "can get composite name" do
    skip "Cannot test in this environment" unless Attendee.connected?
    a = Attendee.find_by_LAST_NAME( "Shappe" )
    assert_equal "Michael Scott Shappe", a.name
  end

end
