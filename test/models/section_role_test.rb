# == Schema Information
#
# Table name: section_roles
#
#  id               :integer          not null, primary key
#  section_id       :integer
#  role_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  permission_flags :jsonb            not null
#

require 'test_helper'

class SectionRoleTest < ActiveSupport::TestCase
  should belong_to :section
  should belong_to :role

  context 'Permission flag delegation' do
    setup do
      @sr = SectionRole.create! section: create(:section), role: create(:role)
    end

    should 'start out with no permissions' do
      assert_equal(@sr.permission_flags, {})
      assert_nil(@sr.read)
      assert_nil(@sr.write)
      assert_nil(@sr.secure)
    end

    should 'reflect permissions in both the JSON and the accessor' do
      @sr.read = true
      assert(@sr.permission_flags[:read])
    end
  end
end
