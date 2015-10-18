class DutyBoardController < ApplicationController
  # This controller is a bit of a mess, honestly, in that it actually relies on three different models to make its
  # magic happen. The index is based on departments, assignment is based DutyBoardSlots, but creates
  # DutyBoardAssignements...yeah. Just a mess. I'm sure there's a better way, and eventually, I'll do it that way.
  respond_to :html

  skip_before_filter :require_login, only: [:index]
  skip_authorization_check only: [:index]

  def index
    @duty_board_groups = DutyBoardGroup.order(:row, :column)

  end

end
