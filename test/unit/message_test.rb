# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  for          :string
#  hotel        :string
#  is_active    :boolean          default(TRUE)
#  message      :text
#  phone_number :string
#  room_number  :string
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to :user
  should validate_presence_of :for
  should validate_presence_of :message
  should allow_value('444 444 4444').for :phone_number
  should_not allow_value('llama').for :phone_number
end
