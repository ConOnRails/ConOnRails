# == Schema Information
#
# Table name: radio_assignments
#
#  id            :integer          not null, primary key
#  radio_id      :integer
#  volunteer_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#  department_id :integer
#

require 'test_helper'

class RadioAssignmentTest < ActiveSupport::TestCase
  should belong_to :radio
  should belong_to :volunteer
  should belong_to :department
  should validate_presence_of :radio
  should validate_uniqueness_of :radio_id
  should validate_presence_of :volunteer
  should validate_uniqueness_of :volunteer_id
  should validate_presence_of :department

  context 'validate department allotments' do
    setup do
      @assignment = FactoryGirl.create :valid_radio_assignment
      @bad_assignment = FactoryGirl.build(:valid_radio_assignment, department: @assignment.department)
    end

    should 'not allow a new assignment' do
      refute @bad_assignment.valid?, 'Assignment should not be valid'
    end
  end
end
