require 'acts-as-taggable-on'
module AlertTags
  extend ActiveSupport::Concern
  include Truthiness

  TAGS = %w(dispatcher)

  included do
    acts_as_taggable_on :alerts
  end

  TAGS.each do |t|
    define_method "alert_#{t}=".to_sym do |flag|
      if is_truthy? flag
        self.alert_list.add t
      else
        self.alert_list.remove t
      end
    end

    define_method "alert_#{t}".to_sym do
      self.alert_list.include? t
    end
  end
end