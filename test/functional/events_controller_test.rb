require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  context "Given some events" do
    setup do
      @section = create :section
      @event        = FactoryGirl.create :ordinary_event
      @event.sections << @section
      @event.save!

      # We'll want these for search tests later
      FactoryGirl.create :entry, description: 'Voles are in control', event: @event
    end

    multiple_contexts :admin_context, :typical_context do
      context 'An index filter set on the session' do
        setup do
          @hotel_event = FactoryGirl.create :ordinary_event, hotel: true
          session[:index_filter] = { 'hotel' => true }
        end

        context 'GET :index' do
          setup do
            get :index
          end

          should respond_with :success
          should 'have one hotel event' do
            assert_equal 1, assigns[:events].count
            assigns[:events].each do |e|
              assert e.hotel?
            end
          end
        end
      end
    end

    multiple_contexts :admin_context, :typical_context, :peon_context do
      context 'Only ordinary events' do
        context 'GET :index' do
          setup do
            get :index
          end

          should respond_with :success

          should 'have one, ordinary event' do
            assert_equal 1, assigns[:events].count
            assigns[:events].each do |e|
              assert e.is_active
              assert !e.sticky
            end
          end
        end


        context 'GET :tag (get tagged entries with a specific tag)' do
          setup do
            @event.alert_list.add('dispatcher')
            @event.save!
            get :tag, tag: 'dispatcher', format: :json
          end

          should respond_with :success
          should render_template :index

          should 'have one tagged event' do
            assert_equal 1, assigns[:events].count
          end
        end

        context 'GET :show for an ordinary event' do
          setup do
            @section.users << @user
            @section.save!

            get :show, { id: @event.to_param }, @admin_session
          end

          should respond_with :success
          should render_template :show
        end
      end

      context 'Also a sticky event' do
        setup do
          @section.users << @user
          @section.save!

          @sticky_event = FactoryGirl.create :ordinary_event, sticky: true
          @sticky_event.sections << @section
          @sticky_event.save!
        end

        context 'GET :sticky' do
          setup do
            get :sticky
          end

          should respond_with :success

          should 'have one, sticky event' do
            assert_equal 1, assigns[:events].count
            assigns[:events].each do |e|
              assert e.sticky
              assert !e.secure
            end
          end
        end


        context 'GET :show for a sticky event' do
          setup do
            get :show, { id: @sticky_event.to_param }, @admin_session
          end

          should respond_with :success
          should render_template :show
        end
      end
    end

    user_context :admin_context do
      context 'POST :search_entries' do
        setup do
          post :search_entries, q: 'vole'
        end

        should respond_with :success
        should render_template :search_entries

        should 'Have both entries because we can see secure' do
          assert_equal 1, assigns(:events).count(:all)
        end
      end

      context 'POST :search_entries with convention limit' do
        setup do
          @convention = create :convention
          @event.created_at = DateTime.now + 2.days # in range
          @event.save!

          post :search_entries, q: 'vole', convention: @convention.id

        end

        should respond_with :success
        should render_template :search_entries

        should 'Have one event' do
          assert_equal 1, assigns(:events).count(:all)
        end
      end

      context 'GET :review with no filters' do
        setup do
          get :review
        end

        should respond_with :success
        should 'have all possible events' do
          assert_equal Event.count, assigns(:events).count(:all)
        end
      end

      (Event::FLAGS - %w'is_active').each do |f|
        context "GET :review with #{f} true" do
          setup do
            @event.send("#{f}=".to_sym, true)
            @event.save!
            get :review, { filters: { f => 'true' } } # we'll get string, not bool
          end

          should respond_with :success
          should "have one event for #{f}" do
            assert_equal ([:secure, :hidden].include?(f.to_sym) ? 2 : 1), assigns(:events).count
            assert assigns(:events).first.send("#{f}?".to_sym)
          end
        end
      end

      context 'GET :review with multiple \'true\' filters' do
        setup do
          FactoryGirl.create :ordinary_event, hotel: true, parties: true
          get :review, { filters: { hotel: true, parties: true } }
        end

        should respond_with :success
        should "have one events" do
          assert_equal 1, assigns(:events).count
        end
      end

      context 'GET :review with mixed filters' do
        setup do
          FactoryGirl.create :ordinary_event, hotel: true
          FactoryGirl.create :ordinary_event, parties: true
          get :review, { filters: { hotel: true, parties: false, sticky: 'all' } }
        end

        should respond_with :success
        should "have one events" do
          assert_equal 1, assigns(:events).count
        end
      end
    end

    multiple_contexts :peon_context, :typical_context do
      context 'POST :search_entries' do
        setup do
          post :search_entries, q: 'vole'
        end

        should respond_with :success
        should render_template :search_entries

        should 'Only have one entry because we cannot see secure' do
          assert_equal 1, assigns(:events).count(:all)
        end
      end

      context 'GET :review with no filters' do
        setup do
          get :review
        end
      end

      (Event::FLAGS - %w'is_active').each do |f|
        context "GET :review with #{f} true" do
          setup do
            @event.send("#{f}=".to_sym, true)
            @event.save!
            get :review, { filters: { f => true } }
          end

          should respond_with :success
          should "have one event for #{f}" do
            assert assigns(:events).first.send("#{f}?".to_sym) if assigns(:events).present?
          end
        end
      end
    end

    multiple_contexts :admin_context, :typical_context do
      setup do
        @section.users << @user
        @section.save!
      end

      context 'GET :new' do
        setup do
          get :new
        end

        should respond_with :success
        should render_template :new
      end

      context 'GET :new emergency' do
        setup do
          get :new, { emergency: '1' }
        end

        should respond_with :success
        should render_template :new
        should 'have an emergency-flagged event' do
          assert_equal true, assigns(:event).emergency
        end
      end

      context 'POST :create' do
        setup do
          post :create, { event: FactoryGirl.attributes_for(:ordinary_event),
                          entry: FactoryGirl.attributes_for(:verbose_entry) }
        end

        should respond_with :redirect
        should redirect_to('the item') { event_url assigns(:event) }
      end

      context 'GET :edit' do
        setup do
          get :edit, { id: @event.to_param }
        end

        should respond_with :success
        should render_template :edit
      end

      context 'PUT :update' do
        setup do
          put :update, { id:    @event.to_param, event: FactoryGirl.attributes_for(:ordinary_event),
                         entry: FactoryGirl.attributes_for(:verbose_entry) }
        end

        should respond_with :redirect
        should redirect_to('the item') { event_url @event }
      end

      context 'PUT :update with changed flags' do
        setup do
          @num_history = EventFlagHistory.count
          put :update, { id: @event.to_param, event: { sticky: true } }
        end

        should 'generate new history entry' do
          assert_equal @num_history + 1, EventFlagHistory.count
        end
      end

      context 'PUT :update without changed flags' do
        setup do
          @num_history = EventFlagHistory.count
          put :update, { id: @event.to_param }
        end

        should 'not generate new history entry' do
          assert_equal @num_history, EventFlagHistory.count
        end
      end

      context 'A second ordinary event' do
        setup do
          @merge_me = FactoryGirl.create :ordinary_event
        end

        context 'POST :merge two events' do
          setup do
            post :merge_events, merge_ids: [@event.id, @merge_me.id]
          end

          should respond_with :redirect
          should redirect_to('edit the merged item') { edit_event_url assigns(:event) }
        end
      end
    end

    user_context :peon_context do
      context 'GET :new' do
        setup do
          get :new
        end

        should respond_with :redirect
        should redirect_to('public') { :public }
      end

      context 'POST :create' do
        setup do
          post :create, { event: FactoryGirl.attributes_for(:ordinary_event),
                          entry: FactoryGirl.attributes_for(:verbose_entry) }
        end

        should respond_with :redirect
        should redirect_to('public') { :public }
      end

      context 'GET :edit' do
        setup do
          get :edit, { id: @event.to_param }
        end

        should respond_with :redirect
        should redirect_to('public') { :public }
      end

      context 'PUT :update' do
        setup do
          put :update, { id:    @event.to_param, event: FactoryGirl.attributes_for(:ordinary_event),
                         entry: FactoryGirl.attributes_for(:verbose_entry) }
        end

        should respond_with :redirect
        should redirect_to('public') { :public }
      end
    end
  end
end
