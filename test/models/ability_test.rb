require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  context 'Event abilities' do
    setup do
      @user = create :user
      @event = create :event
      @section = create :section
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
        assert @ability.can? :read, @event
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
