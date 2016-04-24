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
  belongs_to :event, inverse_of: :event_sections
  belongs_to :section, inverse_of: :event_sections
end
