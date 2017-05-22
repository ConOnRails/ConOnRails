# == Schema Information
#
# Table name: entries
#
#  id          :integer          not null, primary key
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  event_id    :integer
#  rolename    :string
#

require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  should belong_to :event
  should belong_to :user
  should validate_presence_of :description
  should validate_presence_of :user
  should validate_presence_of :event
end
