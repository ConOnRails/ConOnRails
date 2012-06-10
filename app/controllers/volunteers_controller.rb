class VolunteersController < ApplicationController
  before_filter :can_admin_users?
  respond_to :html, :json

  def attendees
    if params[:term]
      terms = params[:term].split
      if terms.size == 1
        like      = "#{terms[0]}%"
        attendees = Attendee.order("FIRST_NAME").where("FIRST_NAME like ? or LAST_NAME like ?", like, like)
      elsif terms.size == 2
        first_like  = "#{terms[0]}%"
        second_like = "#{terms[1]}%"
        attendees   = Attendee.order("LAST_NAME").where("FIRST_NAME like ? and ( MIDDLE_NAME like ? or LAST_NAME like ? )",
                                                        first_like, second_like, second_like)
      elsif terms.size == 3
        first_like  = "#{terms[0]}%"
        second_like = "#{terms[1]}%"
        third_like  = "#{terms[2]}%"
        attendees   = Attendee.order("LAST_NAME").where("FIRST_NAME like ? and MIDDLE_NAME like ? and LAST_NAME like ?",
                                                        first_like, second_like, third_like)
      end
    else
      attendees = Attendee.all
    end

    @list = attendees.map { |a| Hash[id:          a.ATTENDEE_ID,
                                     label:       a.name,
                                     first_name:  a.FIRST_NAME,
                                     middle_name: a.MIDDLE_NAME,
                                     last_name:   a.LAST_NAME,
                                     address1:    a.ADDRESS_LINE_1,
                                     address2:    a.ADDRESS_LINE_2,
                                     address3:    a.ADDRESS_LINE_3,
                                     city:        a.ADDRESS_CITY,
                                     state:       a.ADDRESS_STATE_CODE,
                                     postal:      (a.ADDRESS_ZIP.empty? ? a.FOREIGN_POSTAL_CODE : a.ADDRESS_ZIP),
                                     home_phone:  a.HOME_PHONE,
                                     work_phone:  a.WORK_PHONE,
                                     other_phone: a.OTHER_PHONE,
                                     email:       a.EMAIL]
    }

    render json: @list
  end

  # GET /volunteers
  # GET /volunteers.json
  def index
    @volunteers = Volunteer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @volunteers }
    end
  end

  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @volunteer }
    end
  end

  # GET /volunteers/new
  # GET /volunteers/new.json
  def new
    @volunteer = Volunteer.new
    @volunteer.build_volunteer_training

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @volunteer }
    end
  end

  # GET /volunteers/1/edit
  def edit
    @volunteer = Volunteer.find(params[:id])
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @volunteer = Volunteer.new(params[:volunteer])

    respond_to do |format|
      if @volunteer.save
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully created.' }
        format.json { render json: @volunteer, status: :created, location: @volunteer }
      else
        format.html { render action: "new" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.json
  def update
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      if @volunteer.update_attributes(params[:volunteer])
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_user
    params[:volunteer_id] = params[:id]
    redirect_to :new_user
  end
end
