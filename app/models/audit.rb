# frozen_string_literal: true

# == Schema Information
#
# Table name: audits
#
#  id              :integer          not null, primary key
#  action          :string
#  associated_type :string
#  auditable_type  :string
#  audited_changes :text
#  comment         :string
#  remote_address  :string
#  user_type       :string
#  username        :string
#  version         :integer          default("0")
#  created_at      :datetime
#  associated_id   :integer
#  auditable_id    :integer
#  user_id         :integer
#
# Indexes
#
#  associated_index            (associated_id,associated_type)
#  auditable_index             (auditable_id,auditable_type)
#  index_audits_on_created_at  (created_at)
#  user_index                  (user_id,user_type)
#

class Audit < ApplicationRecord
end
