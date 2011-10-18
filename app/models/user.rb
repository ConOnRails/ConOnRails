class User < ActiveRecord::Base    
    name_regex = /^[a-zA-Z0-9_]*$/
    
    validates :name, presence: true, 
                     allow_blank: false, 
                     uniqueness: true, 
                     length: { maximum: 32 },
                     format: { with: name_regex }
    validates :realname, presence: true, allow_blank: true, length: { maximum: 64 }
    has_secure_password
end
