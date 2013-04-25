class Attendee < ActiveRecord::Base
  establish_connection :attendees

  self.table_name = "2012"
  self.primary_key = "attendee_id"

  def name
    return nil unless self.present?
    self.FIRST_NAME + " " +
        ( self.MIDDLE_NAME.blank? ? "" : self.MIDDLE_NAME + " " ) +
        self.LAST_NAME
  end
end
