class RadioAssignment < ActiveRecord::Base
  belongs_to :radio
  belongs_to :volunteer
  belongs_to :department
  validates_presence_of :radio, :volunteer, :department
  validates_uniqueness_of :radio # Only one instance of a radio checkout at a time!
end
