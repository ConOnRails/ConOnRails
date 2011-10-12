class User < ActiveRecord::Base
    validates :name, uniqueness: true, allow_blank: false
    validates :realname, presence: true, allow_blank: true
    has_secure_password
end
