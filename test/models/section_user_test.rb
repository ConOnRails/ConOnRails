require 'test_helper'

class SectionUserTest < ActiveSupport::TestCase
  should belong_to(:section).inverse_of :section_users
  should belong_to(:user).inverse_of :section_users
end
