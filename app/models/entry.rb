# == Schema Information
#
# Table name: entries
#
#  id          :integer          not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  event_id    :integer
#  rolename    :string(255)
#

class Entry < ActiveRecord::Base
  attr_accessible :description

  audited associated_with: :event
  audited associated_with: :user

  belongs_to :event
  belongs_to :user


  validates :description, presence: true, allow_blank: false
  validates :user, presence: true, allow_blank: false
  validates :event, presence: true, allow_blank: false
end
