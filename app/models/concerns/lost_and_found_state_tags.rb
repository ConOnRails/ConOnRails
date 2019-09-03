# frozen_string_literal: true

module LostAndFoundStateTags
  extend ActiveSupport::Concern
  include Truthiness

  STATES = %w[reported_missing found returned inventoried].freeze

  included do
    acts_as_ordered_taggable_on :lost_and_found_states

    scope :found, -> { tagged_with('found', on: :lost_and_found_states) }
    scope :missing, -> { tagged_with('missing', on: :lost_and_found_states) }
    scope :returned, -> { tagged_with('returned', on: :lost_and_found_states) }
    scope :not_returned, -> { tagged_with('returned', on: :lost_and_found_states, exclude: true) }
    scope :inventoried, -> { tagged_with('inventoried', on: :lost_and_found_states) }
    scope :not_inventoried, lambda {
                              tagged_with('inventoried', on: :lost_and_found_states,
                                                         exclude: true)
                            }
    scope :inventory, lambda { |i, x|
      return nil unless i

      r = found.not_returned
      r = r.not_inventoried if x
      r
    }
  end

  STATES.each do |t|
    define_method "#{t}=".to_sym do |flag|
      if is_truthy? flag
        lost_and_found_state_list.add t
      else
        lost_and_found_state_list.remove t
      end
    end

    define_method "#{t}?".to_sym do
      lost_and_found_state_list.include? t
    end

    define_method t.to_s.to_sym do
      send("#{t}?")
    end
  end
end
