# frozen_string_literal: true

# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer
#  user_id :integer
#
# Indexes
#
#  index_roles_users_on_role_id_and_user_id  (role_id,user_id) UNIQUE
#

class RolesUsers < ApplicationRecord
  has_paper_trail
  belongs_to :role
  belongs_to :user
end
