class Event < ActiveRecord::Base
  has_many :entries, dependent: :destroy, order: 'created_at ASC'
  validates_associated :entries
  accepts_nested_attributes_for :entries, allow_destroy: true

  STATUSES = ['Active', 'Closed']

  def self.num_active
    return Event.count(conditions: "is_active == 't'")
  end

  def self.num_inactive
    return Event.count(conditions: "is_active != 't'")
  end

  def self.num_active_emergencies
    return Event.count(conditions: "is_active == 't' and emergency == 't'")
  end

  def status
    return 'Active' if is_active?
    return 'Closed' unless is_active?
  end

  def status=(string)
    raise Exception if string != 'Active' and string != 'Closed'
    self.is_active = true if string == 'Active'
    self.is_active = false if string == 'Closed'
  end

  def self.statuses
    return STATUSES
  end
end
