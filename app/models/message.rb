# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  for          :string
#  phone_number :string
#  room_number  :string
#  hotel        :string
#  user_id      :integer
#  message      :text
#  is_active    :boolean          default(TRUE)
#  created_at   :datetime
#  updated_at   :datetime
#

class Message < ApplicationRecord
  has_paper_trail

  paginates_per 10

  belongs_to :user
  validates :for, :message, :user, presence: true
  validates :phone_number,  format: { allow_blank: true, message: 'must be a valid telephone number.',
                                      with: /\A[\(\)0-9\- \+\.]{10,20}\z/ }

  def self.num_active
    Message.where(is_active: true).count
  end
end
