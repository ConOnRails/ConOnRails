class Radio < ActiveRecord::Base
  belongs_to :radio_group
  validates_associated :radio_group
  validates_presence_of :number
  validates_uniqueness_of :number, scope: :radio_group_id

  def name
    self.number
  end
end
