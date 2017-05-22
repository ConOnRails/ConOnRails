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

require 'test_helper'

class LoginLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
