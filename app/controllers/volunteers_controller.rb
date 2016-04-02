class VolunteersController < ApplicationController
  load_and_authorize_resource

  before_action :set_volunteers, only: [:index]

  respond_to :html, :json

  def attendees
    # DEAD LETTER for 2013

    render json: @list
  end


  # GET /volunteers/new
  # GET /volunteers/new.json
  def new
    @volunteer = Volunteer.new
    @volunteer.build_volunteer_training
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @volunteer = Volunteer.new volunteer_params
    @volunteer.save
    make_user_if_needed
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.json
  def update
    make_user_if_needed if @volunteer.update_attributes volunteer_params
  end

  def new_user
    params[:volunteer_id] = params[:id]
    redirect_to :new_user
  end

  def clear_all_radio_training
    Volunteer.find_each do |v|
      v.volunteer_training.radio = false
      v.save!
    end

    redirect_to :volunteers
  end

  protected

  def make_user_if_needed
    respond_with @volunteer do |format|
      if params[:make_user_after_save]
        flash[:notice] = "Volunteer created, create a user"
        format.html { redirect_to new_user_path({ realname: @volunteer.name, volunteer_id: @volunteer.id }) }
      else
        flash[:notice] = 'Volunteer was successfully created.'
      end
    end
  end

  def set_volunteers
    @q          = Volunteer.search params[:q]
    @q.sorts = ['last_name', 'first_name'] if @q.sorts.empty?
    @volunteers = @q.result.page(params[:page])
  end

  def volunteer_params
    params.require(:volunteer).permit :can_have_multiple_radios, :first_name, :middle_name, :last_name, :address1, :address2, :address3, :city, :state, :postal,
                                      :country, :home_phone, :work_phone, :other_phone, :email, :user_id,
                                      { volunteer_training_attributes: [:volunter_id, :radio, :ops_basics, :first_contact,
                                                                        :communications, :dispatch,
                                                                        :wandering_host, :xo, :ops_subhead, :ops_head] }
  end
end
