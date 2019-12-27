# frozen_string_literal: true

require Rails.root + 'app/queries/event_queries'

class EventsController < ApplicationController
  include Queries::EventQueries

  before_action :set_event, only: %i[show edit update]
  before_action :get_tagged_events, only: [:tag]
  before_action :process_filters, only: %i[review export]

  respond_to :html, :json, except: [:export]
  respond_to :js, only: %i[index sticky secure review]
  respond_to :csv, only: [:export]

  # GET /events
  # GET /events.json
  def index
    @title = 'Active Events'
    return jump if params[:id].present?

    @events = IndexQuery.new(policy_scope(Event)).query(session[:index_filter])
                        .order(updated_at: :desc)
                        .preload(:event_flag_histories)
                        .preload(:entries)
                        .page(params[:page])
    authorize @events
    respond_with @events
  end

  def sticky
    authorize Event

    @title = 'Sticky Events'
    @events = (limit_by_convention StickyQuery.new(policy_scope(Event)).query
                .order(updated_at: :desc)
                .preload(:event_flag_histories)
                .preload(:entries))
              .page(params[:page])

    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def secure
    authorize Event

    @title = 'Secure Events'
    @events = SecureQuery.new(Event).query
                         .order(updated_at: :desc)
                         .preload(:event_flag_histories)
                         .preload(:entries)
                         .page(params[:page])
    respond_with @events do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def tag
    authorize Event
    respond_with do |format|
      format.json { render :index }
    end
  end

  def search_entries
    authorize Event
    
    @q = params[:q] # We'll use this to re-fill the search blank
    @events = limit_by_convention(policy_scope(Event).ransack(@q, current_user,
                                                      params[:show_closed],
                                                      session[:index_filter]))
              .page(params[:page])
    respond_with @events
  end

  def review
    authorize Event
    @title = 'Event Review'
    respond_with @events
  end

  # GET /events/1
  # GET /events/1.json
  def show    
    @title = 'Event'
    @entry = build_new_entry @event
  end

  # GET /events/new
  # GET /events/new.json
  # There is POST /events. We actually create the new event here and then redirect to create the first entry
  def new
    @title = 'New Event'
    @event = Event.new
    authorize @event

    @event.flags = session[:index_filter] if session[:index_filter]
    @event.emergency = true if params[:emergency] == '1'
    @entry = build_new_entry @event
  end

  def create
    @event = Event.new event_params
    authorize @event

    if @event.save
      build_entry_from_params @event, entry_params
      build_flag_history_from_params @event, event_params, true
    end

    if @event.save # save the extra bits
      flash[:notice] = 'Event was successfully created.'
    else
      flash[:error] = 'Event creation failed'
    end

    respond_with @event, location: -> { events_path }
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    # strong_parameters balks a bit at the permissiveness of this. Might want to consider restructuring a bit
    build_entry_from_params @event, entry_params if params.key? :entry # this can be blank!
    build_flag_history_from_params @event, event_params if params.key? :event # this can also be blank if nothing changed!

    if params.key? :event
      if @event.update event_params
        flash[:notice] = 'Event was successfully updated.' 
        @event.save!
      end
    else
      flash[:notice] = 'Event was successfully updated.' if @event.save
    end

    respond_with @event, location: -> { events_path }
  end

  def merge_events  
    authorize Event
    merge_events = policy_scope(Event).where(id: merge_id_params)
    @event = Event.merge_events merge_events, current_user, current_role_name
    if @event.present?
      flash[:notice] = 'Event was merged. Check and save.'
      respond_with @event, location: edit_event_path(@event)
    else
      redirect_to request.referer, notice: 'No IDs selected for merge. Nothing done.'
    end
  end

  def export
    respond_with do |f|
      f.csv { send_data Event.to_csv(@events), type: 'text/csv' }
    end
  end

  protected

  def build_new_entry(event)
    event.entries.build event: event, user: current_user, rolename: current_role_name
  end

  def build_entry_from_params(event, params)
    return unless params && (params[:description] != '')

    event.entries.build(params.merge(event: event, user: current_user, rolename: current_role_name))
  end

  def build_flag_history_from_params(event, params, always = false)
    return unless always || (params && @event.flags_differ?(params))

    event.event_flag_histories.build(params.merge(event: event, user: current_user,
                                                  rolename: current_role_name))
  end

  def filter_order
    params.permit(filters: :order).fetch(:filters, {}).fetch(:order, 'asc')
  end

  def get_tagged_events
    @events = IndexQuery.new(policy_scope(Event)).query
                        .tagged_with(params[:tag])
                        .preload(:event_flag_histories)
                        .preload(:entries)
                        .order(updated_at: :desc)
  end

  def jump
    event = policy_scope(Event).find_by(id: top_params[:id])
    authorize event
    return redirect_to event_path(event) if event.present?

    render 'lost_and_found_items/invalid'
  end

  def process_filters
    @q = top_params[:q]

    @events = FiltersQuery.new(policy_scope(Event),
                               top_params[:filters])
                          .query
                          .protect_sensitive_events(current_user)
    @events = limit_by_convention @events
    @events = limit_by_date_range @events
    @events = @events.search_entries(@q) if @q.present?
    @events = @events.order(updated_at: filter_order)
    @events = @events.page(top_params[:page])
  end

  def set_event
    @event = Event.find(top_params[:id])
    authorize @event
  end

  def top_params
    params.permit(:convention, :id, :page, :q, filters: %i[is_active comment flagged post_con quote sticky emergency
                                                           medical hidden secure consuite hotel parties volunteers
                                                           dealers dock merchandise nerf_herders status alert_dispatcher tag
                                                           accessibility_and_inclusion allocations first_advisors member_advocates
                                                           operations programming registration volunteers_den merged])
  end

  def event_params
    params.require(:event).permit :is_active, :comment, :flagged, :post_con, :quote, :sticky, :emergency,
                                  :medical, :hidden, :secure, :consuite, :hotel, :parties, :volunteers,
                                  :dealers, :dock, :merchandise, :nerf_herders, :status, :alert_dispatcher, :tag,
                                  :accessibility_and_inclusion, :allocations, :first_advisors, :member_advocates,
                                  :operations, :programming, :registration, :volunteers_den
  end

  def entry_params
    params.require(:entry).permit :description, :event, :user, :rolename
  end

  def merge_id_params
    params.require(:merge_ids)
  end
end
