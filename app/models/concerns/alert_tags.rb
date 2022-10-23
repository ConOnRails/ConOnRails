# frozen_string_literal: true

require 'acts-as-taggable-on'
module AlertTags
  extend ActiveSupport::Concern
  include Truthiness

  TAGS = %w[dispatcher].freeze

  included do
    acts_as_taggable_on :alerts
  end

  TAGS.each do |t|
    define_method "alert_#{t}=".to_sym do |flag|
      if truthy? flag
        alert_list.add t
      else
        alert_list.remove t
      end
    end

    define_method "alert_#{t}".to_sym do
      alert_list.include? t
    end
  end
end
