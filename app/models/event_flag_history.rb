class EventFlagHistory < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  def status=(string)
    raise Exception if string != 'Active' and string != 'Closed'
    self.is_active = true if string == 'Active'
    self.is_active = false if string == 'Closed'
  end
end

