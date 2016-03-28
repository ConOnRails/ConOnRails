# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_uniqueness_of :name
  should have_many(:event_sections)
  should have_many(:events).through :event_sections
  should have_many(:section_roles)
  should have_many(:roles).through :section_roles

  context 'scope role_can_read' do
    setup do
      @readable_section = create :section
      @writable_section = create :section
      @securable_section = create :section

      @role = create :role

      SectionRole.create section: @readable_section, role: @role, read: true
      SectionRole.create section: @writable_section, role: @role, write: true
      SectionRole.create section: @securable_section, role: @role, secure: true
    end

    should 'only see readable sections' do
      assert_equal(Section.role_can_read(@role), [@readable_section])
    end

    should 'only see writable sections' do
      assert_equal(Section.role_can_write(@role), [@writable_section])
    end

    should 'only see secure sections we know' do
      assert_equal(Section.role_can_secure(@role), [@securable_section])
    end
  end

  context 'scope user_can' do
    setup do
      @section1 = create :section
      @section2 = create :section

      @role1 = create :role
      @role2 = create :role

      @user = create :user

      @user.roles << @role1
      @user.roles << @role2

      SectionRole.create section: @section1, role: @role1, read: true
      SectionRole.create section: @section2, role: @role2, read: true
    end

    should 'see both sections for reading' do
      assert_equal(Section.user_can(@user, :read), [@section1, @section2])
    end
  end
end
