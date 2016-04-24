# == Schema Information
#
# Table name: login_logs
#
#  id         :integer          not null, primary key
#  user_name  :string(255)
#  role_name  :string(255)
#  comment    :string(255)
#  ip         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class LoginLog < ActiveRecord::Base
  has_paper_trail
end
