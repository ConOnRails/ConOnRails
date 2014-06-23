module CurrentConvention
  extend ActiveSupport::Concern

  included do
    scope :current_convention, -> () {
      where { |e| (e.created_at >= Convention.current_convention.start_date) &
          (e.created_at <= Convention.current_convention.end_date) } unless Convention.current_convention.blank? }

  end
end