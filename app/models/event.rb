class Event < ActiveRecord::Base
  has_many :entries, dependent: :destroy, order: 'created_at ASC'
  validates_associated :entries
  accepts_nested_attributes_for :entries, allow_destroy: true
  has_associated_audits
  paginates_per 10

  STATUSES = ['Active', 'Closed']

  def self.build_permissions(user)
    filter = { }
    filter[:hidden] = false unless user.read_hidden_entries?
    filter[:secure] = false unless user.rw_secure?
    return filter
  end

  def self.build_page_flags(params, filter)
    if params[:active] == true or params[:active] == "true"
      filter[:is_active] = true
    end

    if params[:filters]
      if params[:filters][:active] == "active"
        filter[:is_active] = true
      elsif params[:filters][:active] == "closed"
        filter[:is_active] = false
      end
      if params[:filters][:emergency] == "1"
        filter[:emergency] = true
      end
      if params[:filters][:medical] == "1"
        filter[:medical] = true
      end
      if params[:filters][:hidden] == "1"
        filter[:hidden] = true
      end
      if params[:filters][:secure] == "1"
        filter[:secure] = true
      end
    end
  end

  def self.build_filter(user, params)
    # Filter based on permissions
    filter          = build_permissions(user)
    # Filter based on page flags
    build_page_flags(params, filter)
    Event.where(filter)
  end

  def self.user_can_see_hidden(user)
    return user != nil ? user.read_hidden_entries? : false
  end

  def self.user_can_rw_secure(user)
    return user != nil ? user.rw_secure? : false
  end

  def self.num_active
    return Event.count(conditions: "is_active == 't'")
  end

  def self.num_inactive
    return Event.count(conditions: "is_active != 't'")
  end

  def self.num_active_emergencies
    return Event.count(conditions: "is_active == 't' and emergency == 't'")
  end

  def self.num_active_medicals
    return Event.count(conditions: "is_active == 't' and medical == 't'")
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
