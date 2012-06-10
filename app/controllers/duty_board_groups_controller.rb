class DutyBoardGroupsController < ApplicationController
  before_filter :can_admin_duty_board?

  def index
    @duty_board_groups = DutyBoardGroup.order(:row, :column)
  end

  def new
    @duty_board_group = DutyBoardGroup.new
  end

  def create
    @duty_board_group = DutyBoardGroup.new params[:duty_board_group]

    respond_to do |format|
      if @duty_board_group.save
        format.html { redirect_to :duty_board_groups, message: 'Duty board group created successfully' }
        format.json { render json: @duty_board_group, status: :created, location: @duty_board_group }
      else
        format.html { render action: :new }
        format.json { render json: @duty_board_groups.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @duty_board_group = DutyBoardGroup.find params[:id]
  end

  def update
    @duty_board_group = DutyBoardGroup.find params[:id]

    respond_to do |format|
      if @duty_board_group.update_attributes params[:duty_board_group]
        format.html { redirect_to :duty_board_groups, message: 'Duty board group updated successfully' }
        format.json { render json: @duty_board_group, status: :updated, location: @duty_board_group }
      else
        format.html { render action: :edit }
        format.json { render json: @duty_board_groups.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @duty_board_group = DutyBoardGroup.find params[:id]
    @duty_board_group.destroy

    respond_to do |format|
      format.html { redirect_to :duty_board_groups, message: 'Duty board group deleted' }
      format.json { render head: :ok }
    end
  end
end
