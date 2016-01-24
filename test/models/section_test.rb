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

  context '#add_role' do
    setup do
      @role = create :role
      @section = create :section
    end

    should 'add with valid permission' do
      assert_nothing_raised { @section.add_role!(@role, 'read') }
      assert_equal 1, @section.roles.count
      assert_equal 1, @role.sections.count
    end
  end

  context '::sections_for_roles' do
    context 'one role that can read one section' do
      setup do
        @role = create :role
        @section = create :section

        @section.add_role!(@role, 'read')
      end
      should 'return that section' do
        assert_equal [@section], Section.sections_for_roles([@role], 'read')
      end
    end

    context 'multiple sections for one role can read' do
      setup do
        @role = create :role
        @sections = create_list :section, 3

        @sections.each do |s|
          s.add_role!(@role, 'read')
        end
      end

      should 'return all three sections' do
        assert_equal @sections, Section.sections_for_roles(@role, 'read')
      end
    end

    context 'multiple sections, multiple roles, can read' do
      # Roles in CoR have always been additive. So they are here.
      # I can see all the sections for which I have the relevant roles with
      # the relevant permissions.
      #
      setup do
        @roles = create_list :role, 2
        @sections = create_list :section, 2

        @sections.first.add_role! @roles.first, 'read'
        @sections.last.add_role! @roles.last, 'read'
      end

      should 'return all both sections' do
        assert_equal @sections, Section.sections_for_roles(@roles, 'read')
      end
    end

    context 'multiple sections. multiple roles, multiple permissions' do
      # While specific permissions might be invoked for specific purposes,
      # for the purposes of getting a list of sections we're allowed to touch
      # at all, we want fully additive permissions. Also, it doesn't actually
      # make much sense in practice to be able to 'write' without 'reading'.
      # So most people would have both anyway. BUT, we want uniqueness -- we
      # don't need to see the same section repeatedly.

      setup do
        @roles = create_list :role, 3
        @sections = create_list :section, 2

        @sections.first.add_role! @roles.first, 'read'
        @sections.first.add_role! @roles.first, 'write'
        @sections.last.add_role! @roles[1], 'read'
        @sections.last.add_role! @roles.last, 'write'
      end

      should 'return both sections ONLY ONCE' do
        assert_equal @sections, Section.sections_for_roles(@roles, ['read', 'write'])
      end
    end
  end
end
