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

require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  should belong_to :event
  should belong_to :user
  should validate_presence_of :description
end
