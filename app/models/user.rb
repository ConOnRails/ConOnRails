class User < ActiveRecord::Base    
    validates :name, presence: true, allow_blank: false, uniqueness: true
    validates :realname, presence: true, allow_blank: true
    has_secure_password
end
