require 'test_helper'

class AlertTagsTest < ActiveSupport::TestCase

  setup do
    @event = Event.new # TODO find a better way to test without needing a specific client of the concern
  end

  context '#alert_dispatcher' do
    should 'be false by default' do
      assert !@event.alert_dispatcher
    end

    context 'with "dispatcher" tag set' do
      setup do
        @event.alert_list.add('dispatcher')
      end

      should 'be true' do
        assert @event.alert_dispatcher
      end
    end
  end

  context '#alert_dispatcher?=' do
    setup do
      @event.alert_dispatcher = true
    end

    should 'have "dispatcher" tag' do
      assert @event.alert_list.include? 'dispatcher'
    end
  end
end