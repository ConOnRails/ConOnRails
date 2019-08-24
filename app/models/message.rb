# frozen_string_literal: true

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
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
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
