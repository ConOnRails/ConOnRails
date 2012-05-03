class Entry < ActiveRecord::Base
    belongs_to :event
    belongs_to :user

    audited associated_with: :event
    audited associated_with: :user

    validates :description, presence: true, allow_blank: false
    validates :user, presence: true, allow_blank: false
    validates :event, presence: true, allow_blank: false
end
