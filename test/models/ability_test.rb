require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  context 'Event abilities' do
    setup do
      @user = create :user
      @event = create :event
      @section = create :section
    end

    context 'Admin user manage sections access' do
      setup do
        @role = create :superuser_role
        @user.roles << @role
        @ability = Ability.new @user
      end

      should 'manage sections' do
        assert @ability.can? :manage, @section
      end
    end

    context "Peon user who isn't a section member can't do anything with it" do
      setup do
        @ability = Ability.new @user
      end

      should 'do nothing' do
        assert @ability.cannot? :read, @section
      end
    end

    context 'Bog standard read access' do
      setup do
        @user.sections << @section
        @event.sections << @section
        @user.save!
        @event.save!
        @ability = Ability.new @user
      end

      should 'read' do
        assert @ability.can? :read, @section
#        assert @ability.can? :read, EventSection.first
      end
    end

    context "A user who belongs to no sections can't write anything" do
      setup do
        @ability = Ability.new @user
      end

      should 'not create' do
        assert @ability.cannot? :create, Event
      end
    end
  end
end
