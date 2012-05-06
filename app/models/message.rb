class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :for, :message, :user
  validates_format_of :phone_number,  allow_blank: true, allow_nil: true,
                      message: "must be a valid telephone number.",
                      with:    /^[\(\)0-9\- \+\.]{10,20}$/

end
