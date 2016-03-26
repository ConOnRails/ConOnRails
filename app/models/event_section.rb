# == Schema Information
#
# Table name: event_sections
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventSection < ActiveRecord::Base
  belongs_to :event
  belongs_to :section
end
