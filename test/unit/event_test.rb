# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_active       :boolean          default(TRUE)
#  post_con        :boolean          default(FALSE)
#  sticky          :boolean          default(FALSE)
#  emergency       :boolean          default(FALSE)
#  medical         :boolean          default(FALSE)
#  hidden          :boolean          default(FALSE)
#  secure          :boolean          default(FALSE)
#  consuite        :boolean
#  hotel           :boolean
#  parties         :boolean
#  volunteers      :boolean
#  dealers         :boolean
#  dock            :boolean
#  merchandise     :boolean
#  merged_from_ids :string(255)
#  merged          :boolean
#  nerf_herders    :boolean
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should belong_to :section
  should have_many :entries
  should have_many :event_flag_histories
  should accept_nested_attributes_for :entries

  context 'an ordinary event' do
    setup do
      @event = FactoryGirl.create :ordinary_event
    end

    should 'be active by default' do
      assert @event.is_active?
    end

    should 'have false type flags by default' do
      assert !@event.post_con?
      assert !@event.sticky?
      assert !@event.emergency?
      assert !@event.medical?
      assert !@event.hidden?
      assert !@event.secure?
    end

    should 'have false department flags by default' do
      assert !@event.consuite?
      assert !@event.hotel?
      assert !@event.parties?
      assert !@event.volunteers?
      assert !@event.dealers?
      assert !@event.dock?
      assert !@event.merchandise?
      assert !@event.nerf_herders?
    end

    should 'have correct textual status' do
      assert_equal 'Active', @event.status
      @event.is_active = false
      assert_equal 'Closed', @event.status
    end

    should 'set textual status and get right flags' do
      @event.status = 'Closed'
      assert !@event.is_active?
      @event.status = 'Active'
      assert @event.is_active?
    end

    should 'raise exception on invalid status text' do
      assert_raise Exception do
        @event.status = 'Fudgewidget'
      end
    end

    should 'detect flag changes' do
      params = { hidden: true, secure: false }
      assert @event.flags_differ? params
      params = { hidden: false }
      assert_equal false, @event.flags_differ?(params)
    end

    should 'have tags' do
      # For now, tags are just flags represented as an array of symbols, until we convert flags to tags!
      @event.medical = true
      assert_includes @event.tags, 'medical'
    end

    context 'an additional ordinary event' do
      setup do
        @second_event = FactoryGirl.create :ordinary_event
      end

      should 'have two active events' do
        assert_equal 2, Event.num_active
      end

      context 'one event made inactive' do
        setup do
          @second_event.is_active = false
          @second_event.save!
        end

        should 'have one inactive' do
          assert_equal 1, Event.num_inactive
        end
      end

      context 'one event is secure' do
        setup do
          @event.update_attribute(:secure, true)
        end

        should 'have one secure event' do
          assert_equal 1, Event.num_active_secure
        end
      end

      context 'one event is an emergency' do
        setup do
          @second_event.emergency = true
          @second_event.save!
        end

        should 'have one active emergency' do
          assert_equal 1, Event.num_active_emergencies
        end

        context 'emergency is closed' do
          setup do
            @second_event.status = 'Closed'
            @second_event.save!
          end

          should 'have no active emergencies' do
            assert_equal 0, Event.num_active_emergencies
          end
        end
      end

      context 'one event is an medical' do
        setup do
          @second_event.medical = true
          @second_event.save!
        end

        should 'have one active medical' do
          assert_equal 1, Event.num_active_medicals
        end

        context 'medical is closed' do
          setup do
            @second_event.status = 'Closed'
            @second_event.save!
          end

          should 'have no active medicals' do
            assert_equal 0, Event.num_active_medicals
          end
        end
      end

      context 'can be merged with the original' do
        setup do
          @user = FactoryGirl.create :user
          # make one of them an emergency
          @second_event.emergency = true
          @second_event.save!
          @original_event_flags = @event.flags
          @original_2d_event_flags = @second_event.flags
          @new_event = Event.merge_events([@event.id, @second_event.id], @user, 'vole')
          @event.reload
          @second_event.reload
        end

        should 'have a new merged element' do
          assert_equal @event.entries.count + @second_event.entries.count + 1, @new_event.entries.count
          assert_match /^Merged by #{@user.username} as 'vole'/, @new_event.entries.order(:id).last.description
          assert @event.merged?
          assert @second_event.merged?
          assert_equal [@event.id, @second_event.id], @new_event.merged_from_ids
          assert_equal Event.flags_union(@original_event_flags, @original_2d_event_flags), @new_event.flags
        end
      end

      context 'can search' do
        setup do
          # We need entries with specific text to test searching
          @entry1 = FactoryGirl.create :entry, description: 'Yak fodder', event: @event
          @entry2 = FactoryGirl.create :entry, description: 'Moose pudding', event: @second_event
        end

        context 'search for specific text' do
          setup do
            @foo = Event.search_entries 'Yak'
          end

          should 'yield only the correct event' do
            assert_equal 1, @foo.count(:all)
            assert_equal @event, @foo.first
          end
        end
      end
    end
  end
end
