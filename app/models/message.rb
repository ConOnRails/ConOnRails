# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  for          :string
#  hotel        :string
#  is_active    :boolean          default("true")
#  message      :text
#  phone_number :string
#  room_number  :string
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#

class Message < ApplicationRecord
  has_paper_trail

  paginates_per 10

  belongs_to :user
  validates :for, :message, presence: true
  validates :phone_number,  format: { allow_blank: true,
                                      message: 'must be a valid telephone number.',
                                      with: /\A[()0-9\- +.]{10,20}\z/ }

  def self.num_active
    Message.where(is_active: true).count
  end
end
