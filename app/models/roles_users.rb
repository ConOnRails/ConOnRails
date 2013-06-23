# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer
#  user_id :integer
#

class RolesUsers < ActiveRecord::Base
  attr_accessible :role_id, :user_id
end
