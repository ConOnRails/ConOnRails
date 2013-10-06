class NotTimeTravelingValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.present? && value > record.start_date
      record.errors[attribute] << (options[:message] || 'must be later than Start date!')
    end
  end

end

class Convention < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date
  has_paper_trail

  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true, not_time_traveling: true

  def self.most_recent
    order('start_date desc').first
  end
end
