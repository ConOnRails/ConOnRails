# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id              :integer          not null, primary key
#  name            :string
#  radio_allotment :integer
#  created_at      :datetime
#  updated_at      :datetime
#  radio_group_id  :integer
#  volunteer_id    :integer
#
# Indexes
#
#  index_departments_on_name  (name) UNIQUE
#

require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  setup do
    @department = FactoryBot.create :good_department
  end

  should belong_to :volunteer
  should belong_to :radio_group
  should validate_presence_of :name
  should validate_presence_of :radio_group
  should validate_uniqueness_of :name
  should_not validate_presence_of :volunteer
end
