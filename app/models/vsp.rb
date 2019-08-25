# frozen_string_literal: true

# == Schema Information
#
# Table name: vsps
#
#  id         :integer          not null, primary key
#  name       :string
#  party      :boolean
#  notes      :string
#  created_at :datetime
#  updated_at :datetime
#

class Vsp < ApplicationRecord
  has_paper_trail

  validates :name, presence: true, uniqueness: true

  scope :people, -> { where(party: [nil, false]) }
  scope :parties, -> { where(party: true) }
  def name_and_note
    name.to_s + (notes.present? ? " (#{notes})" : '')
  end
end
