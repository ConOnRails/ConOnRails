# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  for          :string(255)
#  phone_number :string(255)
#  room_number  :string(255)
#  hotel        :string(255)
#  user_id      :integer
#  message      :text
#  is_active    :boolean          default(TRUE)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to :user
  should validate_presence_of :for
  should validate_presence_of :message
  should validate_presence_of :user
  should allow_value("444 444 4444").for :phone_number
  should_not allow_value("llama").for :phone_number

end
