class Attendee < ActiveRecord::Base
  establish_connection :attendees
  set_table_name "2012"
  set_primary_key "attendee_id"

  def name
    return nil if self.blank?
    return self.FIRST_NAME + " " +
        ( self.MIDDLE_NAME.blank? ? "" : self.MIDDLE_NAME + " " ) +
        self.LAST_NAME
  end
end
