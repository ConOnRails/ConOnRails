class Radio < ActiveRecord::Base
  audited

  belongs_to :radio_group
  has_one :radio_assignment
  validates_associated :radio_group
  validates_presence_of :number
  validates_inclusion_of :state, in: %w( in out retired )
  validates_uniqueness_of :number, scope: :radio_group_id
  scope :assigned, where('state = "out"')
  scope :unassigned, where('state = "in"')

  def name
    self.number
  end

end
