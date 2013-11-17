# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer
#  user_id :integer
#

class RolesUsers < ActiveRecord::Base
  has_paper_trail
end
