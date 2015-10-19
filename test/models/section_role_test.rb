require 'test_helper'

class SectionRoleTest < ActiveSupport::TestCase
  should belong_to :section
  should belong_to :role
  should validate_presence_of :permission
  should validate_uniqueness_of(:permission).scoped_to([:section_id, :role_id])
end
