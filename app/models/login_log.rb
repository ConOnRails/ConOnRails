# frozen_string_literal: true

# == Schema Information
#
# Table name: login_logs
#
#  id         :integer          not null, primary key
#  user_name  :string
#  role_name  :string
#  comment    :string
#  ip         :string
#  created_at :datetime
#  updated_at :datetime
#

class LoginLog < ApplicationRecord
  has_paper_trail
end
