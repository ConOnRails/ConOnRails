# frozen_string_literal: true

# == Schema Information
#
# Table name: vsps
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  party      :boolean
#  notes      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
