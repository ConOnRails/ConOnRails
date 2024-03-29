# frozen_string_literal: true

class RadiosController < ApplicationController
  respond_to :html, :json

  before_action :find_radio, only: %i[show edit update destroy checkout transfer select_department]
  before_action :find_radio_assignment, only: %i[select_department]
  before_action :find_radios, only: %i[index new create]

  def index; end
  def show; end

  def new
    @radio = Radio.new
    authorize @radio
  end

  # POST /radios/search_volunteers
  def search_volunteers # rubocop:disable Metrics/MethodLength
    @volunteers = Volunteer.radio_volunteer(params[:first_name],
                                            params[:last_name])
    authorize @volunteers

    respond_with do |format|
      format.html do
        if request.xhr?
          render partial: 'volunteers', locals: { radio: params[:radio] }
        else
          redirect_to root_path
        end
      end
    end
  end

  # GET /radios/1/select_department?volunteer=1
  def select_department # rubocop:disable Metrics/MethodLength
    respond_with do |format|
      format.html do
        if request.xhr?
          render partial: 'select_department', locals: { radio: params[:id],
                                                         radio_group: @radio.radio_group.id,
                                                         volunteer: params[:volunteer] }
        else
          redirect_to root_path
        end
      end
    end
  end

  # GET /radios/new
  # GET /radios/new.json
  def edit; end

  # GET /radios/1/checkout -- just gets the form
  def checkout
    @radio_assignment = RadioAssignment.new
    authorize @radio_assignment
  end

  def transfer
    @radio_assignment = @radio.radio_assignment
    authorize @radio_assignment
  end

  # POST /radios
  # POST /radios.json
  def create
    @radio = Radio.new radio_params
    flash.now[:notice] = 'Radio was successfully created.' if @radio.save
    respond_with @radio, location: radios_path
  end

  # PUT /radios/1
  # PUT /radios/1.json
  def update
    if params[:radio_assignment]
      @radio.radio_assignment = RadioAssignment.new params[:radio_assignment]
    end
    flash.now[:notice] = 'Radio was successfully updated.' if @radio.update radio_params
    respond_with @radio, location: radios_path
  end

  # DELETE /radios/1
  # DELETE /radios/1.json
  def destroy
    @radio.destroy
    respond_with @radio, location: radios_path
  end

  protected

  def find_radio
    @radio = Radio.find(params[:id])
    authorize @radio
  end

  def find_radio_assignment
    @radio_assignment = @radio.radio_assignment || RadioAssignment.new
    authorize @radio_assignment
  end

  def find_radios
    @q = policy_scope(Radio).ransack params[:q]
    @q.sorts = ['state desc', 'radios_number'] if @q.sorts.empty?
    @radios = @q.result(distinct: true).page(params[:page])
    authorize @radios
  end

  def radio_params
    params.require(:radio).permit :radio_group_id, :number, :state, :notes
  end
end
