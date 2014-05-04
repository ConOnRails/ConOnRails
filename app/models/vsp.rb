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

class Vsp < ActiveRecord::Base
  has_paper_trail

  validates :name, presence: true, uniqueness: true

  scope :people, -> { where { |v| (v.party == nil) | (v.party == false) } }
  scope :parties, -> { where { |v| v.party == true } }

  def name_and_note
    "#{self.name}" + (self.notes.present? ? " (#{self.notes})" : '' )
  end
end
