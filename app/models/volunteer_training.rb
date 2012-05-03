class VolunteerTraining < ActiveRecord::Base
  belongs_to :volunteer
  audited associated_with: :volunteer
end
