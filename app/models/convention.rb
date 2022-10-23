# frozen_string_literal: true

# == Schema Information
#
# Table name: conventions
#
#  id         :integer          not null, primary key
#  end_date   :datetime
#  name       :string
#  start_date :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_conventions_on_name  (name) UNIQUE
#

class NotTimeTravelingValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.present? && value > record.start_date

    record.errors[attribute] << (options[:message] || 'must be later than Start date!')
  end
end

class Convention < ApplicationRecord
  has_paper_trail

  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true, not_time_traveling: true

  def self.most_recent
    order('start_date desc').first
  end

  def self.least_recent
    order('start_date asc').first
  end

  def self.current_convention
    where('start_date <= ?', Date.current)
      .find_by('end_date >= ?', Date.current) ||
      Convention.most_recent
  end
end
