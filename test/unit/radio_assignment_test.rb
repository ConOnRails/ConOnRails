# == Schema Information
#
# Table name: radio_assignments
#
#  id            :integer          not null, primary key
#  radio_id      :integer
#  volunteer_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :integer
#

require 'test_helper'

class RadioAssignmentTest < ActiveSupport::TestCase
  setup do
    @valid_assignment = FactoryGirl.build :valid_radio_assignment
  end

  test "can add assignment" do
    assert @valid_assignment.valid?
  end
end
