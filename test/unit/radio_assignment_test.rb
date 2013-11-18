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
  should belong_to :radio
  should belong_to :volunteer
  should belong_to :department
  should validate_presence_of :radio
  should validate_uniqueness_of :radio_id
  should validate_presence_of :volunteer
  should validate_uniqueness_of :volunteer_id
  should validate_presence_of :department
end
