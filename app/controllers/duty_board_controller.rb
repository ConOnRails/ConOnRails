class DutyBoardController < ApplicationController
  # This controller is a bit of a mess, honestly, in that it actually relies on three different models to make its
  # magic happen. The index is based on departments, assignment is based DutyBoardSlots, but creates
  # DutyBoardAssignements...yeah. Just a mess. I'm sure there's a better way, and eventually, I'll do it that way.

  skip_before_filter :require_login, only: [:index]

  def index
    @duty_board_groups = DutyBoardGroup.order(:row, :column)

  end

  def assign_slot
    @duty_board_slot = DutyBoardSlot.find params[:id]
  end

end
