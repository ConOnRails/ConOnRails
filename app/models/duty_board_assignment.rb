# frozen_string_literal: true

# == Schema Information
#
# Table name: duty_board_assignments
#
#  id                 :integer          not null, primary key
#  duty_board_slot_id :integer
#  notes              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  name               :string(255)
#  string             :string(255)
#

class DutyBoardAssignment < ApplicationRecord
  has_paper_trail

  belongs_to :duty_board_slot
  validates :name, presence: { message: 'You must have a name' }
  validates :duty_board_slot, presence: { message: 'You must associate with a duty board slot' }
  validates :notes, length: { maximum: 255 }
end
