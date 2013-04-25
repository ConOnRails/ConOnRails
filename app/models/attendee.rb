class Attendee < ActiveRecord::Base
  begin
    establish_connection :attendees
  rescue => e
    Rails.logger.warn "Attendee database not connected: #{e.message}"
  end

  self.table_name = "2012"
  self.primary_key = "attendee_id"

  def name
    return nil unless self.present? and self.connected?
    return self.FIRST_NAME + " " +
        ( self.MIDDLE_NAME.blank? ? "" : self.MIDDLE_NAME + " " ) +
        self.LAST_NAME
  end
end
