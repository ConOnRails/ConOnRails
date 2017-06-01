module CurrentConvention
  extend ActiveSupport::Concern

  included do
    scope :current_convention, -> () {
      current = Convention.current_convention
      where { |e| (e.created_at >= current.start_date) & (e.created_at <= current.end_date) } unless current.blank? }
  end
end
