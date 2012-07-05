class Event < ActiveRecord::Base
  audited
  has_associated_audits
  has_many :entries, dependent: :destroy, order: 'created_at ASC'
  has_many :event_flag_histories, dependent: :destroy, order: 'created_at ASC'
  validates_associated :entries
  accepts_nested_attributes_for :entries, allow_destroy: true
  paginates_per 10

  STATUSES = %w[ Active Closed ]
  FLAGS    = %w[ is_active comment flagged post_con quote sticky emergency medical hidden secure consuite hotel parties volunteers dealers dock merchandise ]

  def self.build_permissions(user)
    filter = { }
    filter[:hidden] = false unless user.read_hidden_entries?
    filter[:secure] = false unless user.rw_secure?
    return filter
  end

  def self.has_permission(user, field)
    case field
      when :hidden
        user.read_hidden_entries?
      when :secure
        user.rw_secure?
      else
        true
    end
  end

  def self.build_page_flag(user, filter, field, set)
    if filter[field] == "true" and has_permission user, field
      set[field] = true
    elsif filter[field] == "false"
      set[field] = false
    end
    # The key here is that the ABSENCE of any field in the set means we don't filter either way
  end

  def self.build_page_flags(user, params, ands, ors)
    if params[:active] == true or params[:active] == "true"
      ors[:is_active] = true
      ors[:sticky] = true
      ands[:secure] = false
      ands[:hidden] = false
    end

    if params[:secure] == true or params[:secure] == "true"
      ands[:is_active] = true
      ors[:secure] = true
      ors[:hidden] = true
    end

    if params[:filters]
      FLAGS.each do |flag|
        build_page_flag(user, params[:filters], flag, ands)
      end
    end
  end

  def self.build_or(ors)
    ors.inject("") do |filtertext, pair|
      filtertext << "#{pair[0]} = #{pair[1] == true ? "'t'" : "'f'" } OR "
    end.chomp(" OR ")
  end

  def self.build_and(ands)
    ands.inject("") do |filtertext, pair|
      filtertext << "#{pair[0]} = #{pair[1] == true ? "'t'" : "'f'"} AND "
    end.chomp(" AND ")
  end

  def self.build_where(ands, ors)
    "#{build_and ands} #{ ors.count > 0 ?
        "#{ands.count > 0 ? "AND" : "" } ( #{build_or ors} )" : ""} "
  end

  def self.build_filter(user, params)
    # Filter based on permissions
    ands = build_permissions(user)

    # Filter based on page flags
    ors  = { }
    build_page_flags(user, params, ands, ors)

    Event.where(build_where ands, ors)
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

  def flags_differ?(params)
    params.each do |p|
      return true if p.first == "status" and p.second != self.status
      return true if p.first != "status" and
          self[p.first] != ( (p.last == "1" or p.last == true) ? true : false )
    end
    false
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

  def self.flags
    return FLAGS
  end

end
