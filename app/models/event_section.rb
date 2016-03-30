class EventSection < ActiveRecord::Base
  belongs_to :event, inverse_of: :event_sections
  belongs_to :section, inverse_of: :event_sections
end
