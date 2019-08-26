# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                          :integer          not null, primary key
#  created_at                  :datetime
#  updated_at                  :datetime
#  is_active                   :boolean          default(TRUE)
#  post_con                    :boolean          default(FALSE)
#  sticky                      :boolean          default(FALSE)
#  emergency                   :boolean          default(FALSE)
#  medical                     :boolean          default(FALSE)
#  hidden                      :boolean          default(FALSE)
#  secure                      :boolean          default(FALSE)
#  consuite                    :boolean
#  hotel                       :boolean
#  parties                     :boolean
#  volunteers                  :boolean
#  dealers                     :boolean
#  dock                        :boolean
#  merchandise                 :boolean
#  merged_from_ids             :string
#  merged                      :boolean
#  nerf_herders                :boolean
#  accessibility_and_inclusion :boolean
#  allocations                 :boolean
#  first_advisors              :boolean
#  member_advocates            :boolean
#  operations                  :boolean
#  programming                 :boolean
#  registration                :boolean
#  volunteers_den              :boolean
#

require 'csv'
require Rails.root + 'app/queries/event_queries'

class Event < ApplicationRecord
  include PgSearch::Model
  include Queries::EventQueries
  include AlertTags
  include CurrentConvention

  acts_as_taggable_on :corkboard
  has_paper_trail

  serialize :merged_from_ids

  has_many :entries, -> { order :created_at }, dependent: :destroy
  has_many :event_flag_histories, -> { order :created_at }, dependent: :destroy
  validates_associated :entries
  accepts_nested_attributes_for :entries, allow_destroy: true

  paginates_per 10

  pg_search_scope :search_entries, using: { tsearch: { prefix: true } },
                                   associated_against: {
                                     entries: :description
                                   }

  scope :actives_and_stickies_or_all, ->(c) { where(is_active: true).or(where(sticky: true)) unless c }

  scope :protect_sensitive_events, lambda { |user|
    query = Event.all
    query = query.where(hidden: false) unless user_can_see_hidden(user)
    query = query.where(secure: false) unless user_can_rw_secure(user)
    query
  }

  # TODO: this originated with EventQuery and should NOT BE DUPLICATED, but currently is.
  scope :build_from_filters, lambda { |filters|
    query = {}
    filters&.each do |key, value|
      query[key] = (fix_bool value) unless value == 'all'
    end
    where query
  }

  STATUSES = %w[Active Closed Merged].freeze
  STATUS_FLAGS = %w[is_active merged post_con sticky emergency medical hidden secure].freeze
  DEPT_FLAGS = %w[accessibility_and_inclusion allocations consuite dealers first_advisors hotel
                  member_advocates nerf_herders operations parties programming registration volunteers_den volunteers].freeze
  FLAGS = (STATUS_FLAGS + DEPT_FLAGS).freeze

  def self.ransack(q, user, show_closed = false, index_filters = nil)
    protect_sensitive_events(user)
      .actives_and_stickies_or_all(show_closed)
      .build_from_filters(index_filters)
      .search_entries q
  end

  def self.merge_events(event_ids, user, role_name = nil)
    return if event_ids.blank?

    new_event = Event.create! do |event|
      event.merged_from_ids = event_ids
    end

    new_event.merge_entries event_ids
    new_event.merge_flags event_ids
    new_event.add_entry "Merged by #{user.username} as '#{role_name}' from #{event_ids.join(', ')}", user.id, role_name
    new_event.save!
    new_event.reload
  end

  def self.user_can_see_hidden(user)
    !user.nil? ? user.read_hidden_entries? : false
  end

  def self.user_can_rw_secure(user)
    !user.nil? ? user.rw_secure? : false
  end

  def self.num_active
    Event.where(is_active: true).count
  end

  def self.num_inactive
    Event.where.not(is_active: true).count
  end

  def self.num_active_secure
    Event.where(is_active: true, secure: true).count
  end

  def self.num_active_emergencies
    Event.where(is_active: true, emergency: true).count
  end

  def self.num_active_medicals
    Event.where(is_active: true, medical: true).count
  end

  def add_entry(description, user_id, rolename = nil)
    entries << Entry.new do |new_entry|
      new_entry.description = description
      new_entry.user_id = user_id
      new_entry.rolename = rolename
    end
  end

  def flags_differ?(params)
    params.each do |p|
      return true if (p.first == 'status') && (p.second != status)
      return true if (p.first != 'status') &&
                     (self[p.first] != ((p.last == '1') || (p.last == 'true') ? true : false))
    end
    false
  end

  def flags # Note: always returns FALSE for NIL
    FLAGS.each_with_object(HashWithIndifferentAccess.new) do |flag, map|
      map[flag.to_sym] = (send(flag).presence || false)
    end
  end

  def tags
    FLAGS.select do |flag|
      send(flag)
    end
  end

  def flags=(new_flags)
    new_flags.each do |flag, val|
      self[flag] = val
    end
  end

  def merge_flags(event_ids)
    Event.where(id: event_ids).find_each do |ev|
      self.flags = Event.flags_union(flags, ev.flags)
      ev.set_and_save_status 'Merged'
    end
  end

  def self.flags_union(a, b)
    FLAGS.each_with_object(HashWithIndifferentAccess.new) do |flag, map|
      map[flag.to_sym] = a[flag] | b[flag]
    end
  end

  def merge_entries(event_ids)
    Entry.where(event_id: event_ids).order('created_at ASC').find_each do |entry|
      new_entry = entry.dup
      new_entry.created_at = entry.created_at
      entries << new_entry
    end
  end

  def status
    return 'Merged' if merged?
    return 'Active' if is_active?
    return 'Closed' unless is_active?
  end

  def status=(string)
    case string
    when 'Active'
      self.is_active = true
      self.merged = false
    when 'Closed'
      self.is_active = false
      self.merged = false
    when 'Merged'
      self.is_active = false
      self.merged = true
    else
      raise Exception
    end
  end

  def set_and_save_status(string)
    self.status = string
    save!
  end

  def self.statuses
    STATUSES
  end

  def self.flags
    FLAGS
  end

  def self.dept_flags
    DEPT_FLAGS
  end

  def self.to_csv(events)
    CSV.generate do |csv|
      csv << ['ID', 'State', DEPT_FLAGS, 'Entries'].flatten
      events.find_each do |event|
        csv << [
          event.id,
          event.status,
          event.department_flags_to_csv,
          entries_for_export(event)
        ].flatten
      end
    end
  end

  def department_flags_to_csv
    DEPT_FLAGS.collect { |f| send f }
  end

  def self.fix_bool(val)
    if val.is_a? String
      return true if val == 'true'
      return false if val == 'false'
    end
    val
  end

  def self.entries_for_export(event)
    first = event.entries.first
    event.entries.collect do |entry|
      created_or_updated = entry == first ? 'created' : 'update'
      "#{entry.created_at.getlocal.ctime} #{created_or_updated} by #{entry.user.realname} as #{entry.rolename}\r#{entry.description}"
    end.join("\r\r")
  end
end
