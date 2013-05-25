# == Schema Information
#
# Table name: audits
#
#  id              :integer          not null, primary key
#  auditable_id    :integer
#  auditable_type  :string(255)
#  associated_id   :integer
#  associated_type :string(255)
#  user_id         :integer
#  user_type       :string(255)
#  username        :string(255)
#  action          :string(255)
#  audited_changes :text
#  version         :integer          default(0)
#  comment         :string(255)
#  remote_address  :string(255)
#  created_at      :datetime
#

require 'test_helper'

class AuditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
