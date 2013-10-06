# == Schema Information
#
# Table name: radios
#
#  id             :integer          not null, primary key
#  number         :string(255)
#  notes          :string(255)
#  radio_group_id :integer
#  image_filename :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  state          :string(255)      default("in")
#

class Radio < ActiveRecord::Base
  attr_accessible :radio_group_id, :number, :state, :notes

#  audited

  belongs_to :radio_group
  has_one :radio_assignment
  validates_associated :radio_group
  validates_presence_of :number
  validates_inclusion_of :state, in: %w( in out retired )
  validates_uniqueness_of :number, scope: :radio_group_id
  scope :assigned, -> { where { |r| r.state == 'out' } }
  scope :unassigned, -> { where { |r| r.state == 'in' } }

  def name
    self.number
  end

end
