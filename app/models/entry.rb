class Entry < ActiveRecord::Base
    belongs_to :event
    belongs_to :user
    validates :description, presence: true, allow_blank: false
    validates :user, presence: true, allow_blank: false
    validates :event, presence: true, allow_blank: false
end
