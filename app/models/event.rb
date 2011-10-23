class Event < ActiveRecord::Base
    has_many   :entries, dependent: :destroy
    validates  :summary, presence: true, allow_blank: false

    accepts_nested_attributes_for :entries, :allow_destroy => true

    def get_num_entries()
        return entries.count
    end
    
end
