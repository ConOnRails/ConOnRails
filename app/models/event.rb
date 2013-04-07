class Event < ActiveRecord::Base
  attr_accessible :is_active, :comment, :flagged, :post_con, :quote, :sticky, :emergency,
                  :medical, :hidden, :secure, :consuite, :hotel, :parties, :volunteers,
                  :dealers, :dock, :merchandise, :status
  audited
  has_associated_audits
  has_many :entries, dependent: :destroy, order: 'created_at ASC'
  has_many :event_flag_histories, dependent: :destroy, order: 'created_at ASC'
  validates_associated :entries
  accepts_nested_attributes_for :entries, allow_destroy: true
  paginates_per 10

  STATUSES = %w[ Active Closed ]
  FLAGS    = %w[ is_active comment flagged post_con quote sticky emergency medical hidden secure consuite hotel parties volunteers dealers dock merchandise ]


  def self.user_can_see_hidden(user)
    return user != nil ? user.read_hidden_entries? : false
  end

  def self.user_can_rw_secure(user)
    return user != nil ? user.rw_secure? : false
  end

  def self.num_active
    return Event.where { is_active == true }.count
  end

  def self.num_inactive
    return Event.where { is_active != true }.count
  end

  def self.num_active_emergencies
    return Event.where { (is_active == true) & (emergency == true) }.count
  end

  def self.num_active_medicals
    return Event.where { (is_active == true) & (medical == true) }.count
  end

  def flags_differ?(params)
    params.each do |p|
      return true if p.first == "status" and p.second != self.status
      return true if p.first != "status" and
          self[p.first] != ((p.last == "1" or p.last == true) ? true : false)
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
