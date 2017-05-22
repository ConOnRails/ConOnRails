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

class LoginLog < ActiveRecord::Base
  has_paper_trail
end
