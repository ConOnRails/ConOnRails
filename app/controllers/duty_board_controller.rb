class DutyBoardController < ApplicationController
  skip_authorization_check only: :index

  respond_to :html

  def index
    @duty_board_groups = DutyBoardGroup.order(:row, :column)
  end
end
