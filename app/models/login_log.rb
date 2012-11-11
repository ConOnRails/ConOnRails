class LoginLog < ActiveRecord::Base
  attr_accessible :user_name, :role_name, :comment, :ip
  audited
end
