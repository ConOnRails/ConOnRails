class Department < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :radio_group
  validates_presence_of :name
  validates_presence_of :volunteer
  validates_presence_of :radio_group
  validates_uniqueness_of :name
#  validates_associated :volunteer
  # validates :not_too_many
end