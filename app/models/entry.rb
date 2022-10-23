# frozen_string_literal: true

# == Schema Information
#
# Table name: entries
#
#  id          :integer          not null, primary key
#  description :text
#  rolename    :string
#  created_at  :datetime
#  updated_at  :datetime
#  event_id    :integer
#  user_id     :integer
#
# Indexes
#
#  index_entries_on_created_at  (created_at)
#  index_entries_on_event_id    (event_id)
#  index_entries_on_updated_at  (updated_at)
#  index_entries_on_user_id     (user_id)
#

class Entry < ApplicationRecord
  has_paper_trail

  belongs_to :event
  belongs_to :user

  validates :description, presence: true, allow_blank: false
end
