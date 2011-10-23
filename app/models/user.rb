class User < ActiveRecord::Base    
  attr_accessible :name, :realname, :password, :password_confirmation

  name_regex = /^[a-zA-Z0-9_]*$/
  password_regex = /^[a-zA-Z0-9!@#$\%^&*()\-_ ]*$/
    
  validates :name, presence: true, 
                   allow_blank: false, 
                   uniqueness: true, 
                   length: { maximum: 32 },
                   format: { with: name_regex }
  validates :realname, presence: true, 
                       allow_blank: true, 
                       length: { maximum: 64 }
  has_secure_password
  validates :password, on: :create,
                       presence: true,
                       length: { within: 6..32 },
                       format: { with: password_regex }
                       
end
