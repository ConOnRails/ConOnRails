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

class Message < ActiveRecord::Base
  has_paper_trail

  paginates_per 10

  belongs_to :user
  validates_presence_of :for, :message, :user
  validates_format_of :phone_number,  allow_blank: true, allow_nil: true,
                      message: "must be a valid telephone number.",
                      with:    /\A[\(\)0-9\- \+\.]{10,20}\z/

 def self.num_active
    return Message.where { is_active == true }.count
  end

end
