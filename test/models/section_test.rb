require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  should have_many :event_sections
  should have_many(:events).through :event_sections
  should have_many :section_users
  should have_many(:users).through :section_users
  should validate_presence_of :name
  should validate_uniqueness_of :name
end
