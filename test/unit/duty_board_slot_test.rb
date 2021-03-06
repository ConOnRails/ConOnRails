# frozen_string_literal: true

# == Schema Information
#
# Table name: duty_board_slots
#
#  id                  :integer          not null, primary key
#  name                :string
#  duty_board_group_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'test_helper'

class DutyBoardSlotTest < ActiveSupport::TestCase
  setup do
    @dbs = FactoryBot.create :valid_duty_board_slot
  end

  should belong_to :duty_board_group
  should have_one :duty_board_assignment
  should accept_nested_attributes_for :duty_board_assignment
  should validate_presence_of :name
  should validate_presence_of :duty_board_group_id
  should validate_uniqueness_of :name
end
