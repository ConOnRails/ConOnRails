# frozen_string_literal: true

# == Schema Information
#
# Table name: radio_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  color      :string(255)
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RadioGroup < ApplicationRecord
  has_paper_trail

  COLORS = %w[blue red yellow green black].freeze

  #  audited
  has_many :radios
  validates :name, presence: true, allow_blank: false
  validates :color, inclusion: { in: COLORS, message: 'Please select a color!' }

  def num_radios
    radios.count
  end
end
