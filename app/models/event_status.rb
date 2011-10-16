class EventStatus < ActiveRecord::Base
  has_many :events
  validates :name, presence: true, allow_blank: false, uniqueness: true
end