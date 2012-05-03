require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  setup do
    @valid = FactoryGirl.attributes_for :valid_volunteer
    @blank = FactoryGirl.attributes_for :volunteer
  end

  test "cannot create empty" do
    vol = Volunteer.create @blank
    assert vol.invalid?, "Blank should fail"
  end

  test "can create valid" do
    vol = Volunteer.create @valid
    assert vol.valid?, "Should have been valid"
  end

  test "can't create with messed up phone number" do
    @valid[:home_phone] = "Llama"
    vol = Volunteer.create @valid
    assert vol.invalid? "Bad phone number should have choked"
  end

  test "need at least one phone number" do
    @valid[:home_phone] = nil
    @valid[:work_phone] = nil
    @valid[:other_phone] = nil
    vol = Volunteer.create @valid
    assert vol.invalid?, "Should have choked on absence of all three numbers"
  end
end
