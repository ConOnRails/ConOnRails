class Vsp < ActiveRecord::Base
  audited

  attr_accessible :name, :notes, :party

  validates :name, presence: true, uniqueness: true

  scope :people, where { |v| (v.party == nil) | (v.party == false) }
  scope :parties, where { |v| v.party == true }

  def name_and_note
    "#{self.name}" + (self.notes.present? ? " (#{self.notes})" : '' )
  end
end
