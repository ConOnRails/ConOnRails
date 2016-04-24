# == Schema Information
#
# Table name: event_sections
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class EventSectionTest < ActiveSupport::TestCase
  should belong_to(:event).inverse_of :event_sections
  should belong_to(:section).inverse_of :event_sections
end
