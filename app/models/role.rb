class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  name_regex = /^[a-zA-Z0-9_ ]*$/
  
  validates :name, presence: true,
                   allow_blank: false,
                   uniqueness: true,
                   length: { maximum: 32 },
                   format: { with: name_regex }


end
