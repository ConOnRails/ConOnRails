# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class Section < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid

  has_many :event_sections
  has_many :events, through: :event_sections
  has_many :section_users
  has_many :users, through: :section_users

  validates :name, presence: true, uniqueness: true
end
