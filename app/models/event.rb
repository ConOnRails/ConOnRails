class Event < ActiveRecord::Base
    has_many   :entries, dependent: :destroy
    belongs_to :event_status
    belongs_to :event_type
    validates  :summary, presence: true, allow_blank: false
    validates  :event_status, presence: true, allow_blank: false
    validates  :event_type, presence: true, allow_blank: false

    accepts_nested_attributes_for :entries, :allow_destroy => true

    def get_num_entries()
        return entries.count
    end
end
