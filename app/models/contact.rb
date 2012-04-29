class Contact < ActiveRecord::Base
  validates_format_of :cell_phone,
                      message: "must be a valid telephone number.",
                      with:    /^[\(\)0-9\- \+\.]{10,20}$/
  validates :name, presence: true, allow_blank: false
end
