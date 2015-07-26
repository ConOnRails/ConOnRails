class RadiosController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json

#  before_filter :can_assign_radios?, only: [:index, :show, :search_volunteers]
  before_filter :find_radios, only: [:index, :new, :create]

  # POST /radios/search_volunteers
  def search_volunteers
    @volunteers = Volunteer.radio_volunteer(params[:first_name],
                                            params[:last_name])
    respond_with do |format|
      format.html do
        if request.xhr?
          render partial: 'volunteers', locals: {radio: params[:radio]}
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
          render partial: 'select_department', locals: {radio:       params[:id],
                                                        radio_group: @radio.radio_group.id,
                                                        volunteer:   params[:volunteer]}
        else
          redirect_to public_path
        end
      end
    end
  end

  # GET /radios/new
  # GET /radios/new.json
  def new
     @radio  = Radio.new
  end

  # GET /radios/1/checkout -- just gets the form
  def checkout
    @radio_assignment = RadioAssignment.new
  end

  def transfer
    @radio_assignment = @radio.radio_assignment
  end

  # POST /radios
  # POST /radios.json
  def create
    @radio = Radio.new radio_params
    flash[:notice] = 'Radio was successfully created.' if @radio.save
    respond_with @radio, location: radios_path
  end

  # PUT /radios/1
  # PUT /radios/1.json
  def update
    if params[:radio_assignment]
      @radio.radio_assignment = RadioAssignment.new params[:radio_assignment]
    end
    flash[:notice] = 'Radio was successfully updated.' if @radio.update_attributes radio_params
    respond_with @radio, location: radios_path
  end

# DELETE /radios/1
# DELETE /radios/1.json
  def destroy
    @radio.destroy
    respond_with @radio, location: radios_path
  end

  protected

  def find_radios
    @radios ||= Radio.all
    @q = @radios.search params[:q]
    @q.sorts = ['state desc', 'radio_group_name'] if @q.sorts.empty?
    @radios = @q.result.page(params[:page])
  end

  def radio_params
    params.require(:radio).permit :radio_group_id, :number, :state, :notes
  end

end
