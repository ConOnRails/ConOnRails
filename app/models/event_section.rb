class EventSection < ActiveRecord::Base
  belongs_to :event
  belongs_to :section
end
