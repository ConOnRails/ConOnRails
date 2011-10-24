class Event < ActiveRecord::Base
    has_many   :entries, dependent: :destroy
    accepts_nested_attributes_for :entries, allow_destroy: true
    
    # Most uses of Rails nested attributes and routes assume that
    # the parent object is created and saved before children are
    # added. We're not doing it that way, so we create a temporary
    # attribute, 'firstdescription' we can throw onto the form, and
    # then the controller uses it to build the first entry.
    #
    attr_accessor :firstdescription

    STATUSES = [ 'Active', 'Closed' ]

    def get_num_entries
        return entries.count
    end
    
    def status
      return 'Active' if is_active?
      return 'Closed' unless is_active?
    end
    
    def status=( string )
      raise Exception if string != 'Active' and string != 'Closed'
      self.is_active = true if string == 'Active'
      self.is_active = false if string == 'Closed'
    end
    
    def self.statuses
      return STATUSES
    end
end
