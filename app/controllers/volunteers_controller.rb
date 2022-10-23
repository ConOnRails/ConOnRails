# frozen_string_literal: true

class VolunteersController < ApplicationController
  before_action :set_volunteers, only: [:index]
  before_action :set_volunteer, only: %i[show edit update]
  respond_to :html, :json

  def index; end
  def show; end
  def edit; end

  # GET /volunteers/new
  # GET /volunteers/new.json
  def new
    @volunteer = Volunteer.new
    authorize @volunteer

    @volunteer.build_volunteer_training
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @volunteer = Volunteer.new volunteer_params
    authorize @volunteer

    @volunteer.save
    make_user_if_needed
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.json
  def update
    make_user_if_needed if @volunteer.update volunteer_params
  end

  def new_user
    params[:volunteer_id] = params[:id]
    redirect_to :new_user
  end

  def clear_all_radio_training
    policy_scope(Volunteer).find_each do |v|
      authorize v
      v.volunteer_training.radio = false
      v.save!
    end

    redirect_to :volunteers
  end

  protected

  def make_user_if_needed # rubocop:disable Metrics/MethodLength
    respond_with @volunteer do |format|
      if params[:make_user_after_save]
        flash[:notice] = 'Volunteer created, create a user'
        format.html do
          redirect_to new_user_path(realname: @volunteer.name,
                                    volunteer_id: @volunteer.id)
        end
      else
        flash[:notice] = 'Volunteer was successfully created.'
      end
    end
  end

  def set_volunteers
    @q = policy_scope(Volunteer).ransack params[:q]
    @q.sorts = %w[last_name first_name] if @q.sorts.empty?
    @volunteers = @q.result.page(params[:page])
    authorize @volunteers
  end

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
    authorize @volunteer
  end

  def volunteer_params
    params.permit(:id, :q)
    params.require(:volunteer).permit :can_have_multiple_radios, :first_name, :middle_name,
                                      :last_name, :address1, :address2, :address3, :city,
                                      :state, :postal, :country, :home_phone, :work_phone,
                                      :other_phone, :email, :user_id,
                                      volunteer_training_attributes:
                                        %i[volunter_id radio ops_basics
                                           first_contact communications dispatch
                                           wandering_host xo ops_subhead
                                           ops_head]
  end
end
