class RadiosController < ApplicationController
  before_filter :can_admin_radios?, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_assign_radios?, only: [:index, :show, :search_volunteers]
  respond_to :html, :json

  # POST /radios/search_volunteers
  def search_volunteers
    @volunteers = Volunteer.radio_volunteer(params[:first_name],
                                            params[:last_name])
    respond_with do |format|
      format.html do
        if request.xhr?
          render partial: 'volunteers', locals: { radio: params[:radio] }
        else
          redirect_to public_path
        end
      end
    end
  end

  # GET /radios/1/select_department?volunteer=1
  def select_department
    @radio            = Radio.find params[:id]
    @radio_assignment = @radio.radio_assignment || RadioAssignment.new
    respond_with do |format|
      format.html do
        if request.xhr?
          render partial: 'select_department', locals: { radio:       params[:id],
                                                         radio_group: @radio.radio_group.id,
                                                         volunteer:   params[:volunteer] }
        else
          redirect_to public_path
        end
      end
    end
  end

  # GET /radios
  # GET /radios.json
  def index
    @q = Radio.search params[:q]
    @q.sorts = ['radio_group_name', 'state desc'] if @q.sorts.empty?
    @radios = @q.result.page(params[:page])
  end

  # GET /radios/1
  # GET /radios/1.json
  def show
    @radio = Radio.find(params[:id])
  end

  # GET /radios/new
  # GET /radios/new.json
  def new
    # We include the index list in the new page for this one, so we need to provide Ransack bits
    @q      = Radio.search params[:q]
    @q.sorts = ['radio_group_name', 'state desc'] if @q.sorts.empty?
    @radios = @q.result.page(params[:page])
    @radio  = Radio.new
  end

  # GET /radios/1/checkout -- just gets the form
  def checkout
    @radio            = Radio.find params[:id]
    @radio_assignment = RadioAssignment.new
  end

  def transfer
    @radio            = Radio.find params[:id]
    @radio_assignment = @radio.radio_assignment
  end

  # GET /radios/1/edit
  def edit
    @radio = Radio.find(params[:id])
  end

  # POST /radios
  # POST /radios.json
  def create
    @radio = Radio.new(params[:radio])
    flash[:notice] = 'Radio was successfully created.' if @radio.save
    respond_with @radio, location: radios_path
  end

  # PUT /radios/1
  # PUT /radios/1.json
  def update
    @radio = Radio.find(params[:id])
    if params[:radio_assignment]
      @radio.radio_assignment = RadioAssignment.new params[:radio_assignment]
    end
    flash[:notice] = 'Radio was successfully updated.' if @radio.update_attributes(params[:radio])
    respond_with @radio, location: radios_path
  end

# DELETE /radios/1
# DELETE /radios/1.json
  def destroy
    @radio = Radio.find(params[:id])
    @radio.destroy
    respond_with @radio, location: radios_path
  end

end
