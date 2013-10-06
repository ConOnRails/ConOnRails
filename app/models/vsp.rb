class Vsp < ActiveRecord::Base
  attr_accessible :name, :notes, :party
  has_paper_trail

  validates :name, presence: true, uniqueness: true

  scope :people, -> { where { |v| (v.party == nil) | (v.party == false) } }
  scope :parties, -> { where { |v| v.party == true } }

  def name_and_note
    "#{self.name}" + (self.notes.present? ? " (#{self.notes})" : '' )
  end
end
