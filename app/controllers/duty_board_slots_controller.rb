# frozen_string_literal: true

class DutyBoardSlotsController < ApplicationController
  respond_to :html, :json
  layout 'application', except: :assign

  # GET /duty_board_slots
  # GET /duty_board_slots.json
  def index
    @duty_board_slots = policy_scope(DutyBoardSlot).order(:duty_board_group_id, :name)
    authorize @duty_board_slots
  end

  # GET /duty_board_slots/1
  # GET /duty_board_slots/1.json
  def show
    @duty_board_slot = DutyBoardSlot.find(params[:id])
    authorize @duty_board_slot
  end

  def assign
    @duty_board_slot = DutyBoardSlot.find params[:id]
    authorize @duty_board_slot
    @duty_board_slot.build_duty_board_assignment if @duty_board_slot.duty_board_assignment.blank?
    # respond_with @duty_board_slot, location: :duty_board_index
  end

  # GET /duty_board_slots/new
  # GET /duty_board_slots/new.json
  # GET /duty_board_slots/new.json
  def new
    @duty_board_slot = DutyBoardSlot.new
    authorize @duty_board_slot
  end

  # GET /duty_board_slots/1/edit
  def edit
    @duty_board_slot = DutyBoardSlot.find(params[:id])
    authorize @duty_board_slot
  end

  # POST /duty_board_slots
  # POST /duty_board_slots.json
  def create
    @duty_board_slot = DutyBoardSlot.new duty_board_slot_params
    authorize @duty_board_slot

    flash.now[:notice] = 'Duty board slot was successfully created.' if @duty_board_slot.save
    respond_with @duty_board_slot, location: :duty_board_slots
  end

  # PUT /duty_board_slots/1
  # PUT /duty_board_slots/1.json
  def update
    @duty_board_slot = DutyBoardSlot.find(params[:id])
    authorize @duty_board_slot

    @duty_board_slot.update duty_board_slot_params
    respond_with @duty_board_slot, location: :duty_board_slots do |_format|
      # if @duty_board_slot.update duty_board_slot_params
      #           if params[:duty_board_assignment]
      #           if @duty_board_slot.duty_board_assignment
      #             @duty_board_slot.duty_board_assignment
      #                             .update_attributes duty_board_assignment_params
      #           else
      #             @duty_board_slot.build_duty_board_assignment duty_board_assignment_params
      #             @duty_board_slot.save!
      #           end
      # else
      # end
      # end
      flash.now[:notice] = 'Duty board slot was successfully updated'
    end
  end

  # POST /duty_board_slots/1/clear_assignment
  def clear_assignment
    @duty_board_slot = DutyBoardSlot.find params[:id]
    authorize @duty_board_slot

    @duty_board_slot.duty_board_assignment&.destroy

    respond_to do |format|
      format.html do
        redirect_to duty_board_index_path, notice: 'Duty board slot was successfully cleared'
      end
    end
  end

  # DELETE /duty_board_slots/1
  # DELETE /duty_board_slots/1.json
  def destroy
    @duty_board_slot = DutyBoardSlot.find(params[:id])
    authorize @duty_board_slot

    @duty_board_slot.destroy

    respond_to do |format|
      format.html { redirect_to duty_board_slots_url }
      format.json { head :ok }
    end
  end

  protected

  def duty_board_slot_params
    params.require(:duty_board_slot).permit :name, :duty_board_group_id,
                                            duty_board_assignment_attributes: %i[
                                              name notes duty_board_slot_id
                                            ]
  end

  def duty_board_assignment_params
    params.require(:duty_board_assignment).permit :name, :duty_board_slot_id, :notes
  end
end
