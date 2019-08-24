# frozen_string_literal: true

# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer
#  user_id :integer
#

class RolesUsers < ApplicationRecord
  has_paper_trail
end
