# == Schema Information
#
# Table name: volunteers
#
#  id                       :integer          not null, primary key
#  first_name               :string(255)
#  middle_name              :string(255)
#  last_name                :string(255)
#  address1                 :string(255)
#  address2                 :string(255)
#  address3                 :string(255)
#  city                     :string(255)
#  state                    :string(255)
#  postal                   :string(255)
#  country                  :string(255)
#  home_phone               :string(255)
#  work_phone               :string(255)
#  other_phone              :string(255)
#  email                    :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#  can_have_multiple_radios :boolean
#

require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  should have_one :volunteer_training
  should have_many(:radio_assignments)
  should have_many(:radios).through(:radio_assignments)
  should belong_to :user

  should validate_presence_of :first_name
  should validate_presence_of :last_name

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
