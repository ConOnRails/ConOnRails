# == Schema Information
#
# Table name: audits
#
#  id              :integer          not null, primary key
#  auditable_id    :integer
#  auditable_type  :string
#  associated_id   :integer
#  associated_type :string
#  user_id         :integer
#  user_type       :string
#  username        :string
#  action          :string
#  audited_changes :text
#  version         :integer          default(0)
#  comment         :string
#  remote_address  :string
#  created_at      :datetime
#

class Audit < ActiveRecord::Base
end
