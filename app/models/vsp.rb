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

class Vsp < ActiveRecord::Base
  has_paper_trail

  validates :name, presence: true, uniqueness: true

  scope :people, -> { where { |v| (v.party == nil) | (v.party == false) } }
  scope :parties, -> { where { |v| v.party == true } }

  def name_and_note
    "#{self.name}" + (self.notes.present? ? " (#{self.notes})" : '' )
  end
end
