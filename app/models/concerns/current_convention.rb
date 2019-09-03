# frozen_string_literal: true

module CurrentConvention
  extend ActiveSupport::Concern

  included do
    scope :current_convention, lambda {
                                 current = Convention.current_convention
                                 if current.present?
                                   where('created_at >= ?', current.start_date)
                                     .where('created_at <= ?', current.end_date)
                                 end
                               }
  end
end
