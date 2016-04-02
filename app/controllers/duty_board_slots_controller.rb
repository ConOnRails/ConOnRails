class DutyBoardSlotsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json
  layout 'application', except: :assign

  # GET /duty_board_slots
  # GET /duty_board_slots.json
  def index
    @duty_board_slots = @duty_board_slots.order(:duty_board_group_id, :name)
  end

  def assign
    @duty_board_slot.build_duty_board_assignment if @duty_board_slot.duty_board_assignment.blank?
    #respond_with @duty_board_slot, location: :duty_board_index
  end

  # POST /duty_board_slots
  # POST /duty_board_slots.json
  def create
    flash[:notice] = 'Duty board slot was successfully created.' if @duty_board_slot.save
    respond_with @duty_board_slot, location: :duty_board_slots
  end

  # PUT /duty_board_slots/1
  # PUT /duty_board_slots/1.json
  def update
    respond_with @duty_board_slot, location: :duty_board_index do |format|
      if @duty_board_slot.update_attributes duty_board_slot_params
        flash[:notice] = 'Duty board slot was successfully updated'
      else
        flash[:notice] = 'Duty board slot was successfully updated'
        #end
      end
    end
  end

  # POST /duty_board_slots/1/clear_assignment
  def clear_assignment
    if @duty_board_slot.duty_board_assignment
      @duty_board_slot.duty_board_assignment.destroy
    end

    respond_to do |format|
      format.html { redirect_to duty_board_index_path, notice: 'Duty board slot was successfully cleared' }
    end
  end

  # DELETE /duty_board_slots/1
  # DELETE /duty_board_slots/1.json
  def destroy
    @duty_board_slot.destroy

    respond_to do |format|
      format.html { redirect_to duty_board_slots_url }
      format.json { head :ok }
    end
  end

  protected

  def duty_board_slot_params
    params.require(:duty_board_slot).permit :name, :duty_board_group_id, duty_board_assignment_attributes: [:name, :notes, :duty_board_slot_id]
  end
end
