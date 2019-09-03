# frozen_string_literal: true

# == Schema Information
#
# Table name: conventions
#
#  id         :integer          not null, primary key
#  name       :string
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class NotTimeTravelingValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.present? && value > record.start_date
      record.errors[attribute] << (options[:message] || 'must be later than Start date!')
    end
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
      .where('end_date >= ?', Date.current)
      .first || Convention.most_recent
  end
end
