class Section < ActiveRecord::Base
  has_paper_trail

  has_many :event_sections
  has_many :events, through: :event_sections
  has_many :section_users
  has_many :users, through: :section_users

  validates :name, presence: true, uniqueness: true
end
