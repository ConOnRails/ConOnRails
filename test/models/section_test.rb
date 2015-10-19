require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_uniqueness_of :name
  should have_many :events
  should have_many(:roles).through :section_roles
end
