# frozen_string_literal: true

class DutyBoardController < ApplicationController
  # This controller is a bit of a mess, honestly, in that it actually
  # relies on three different models to make its magic happen. The index
  # is based on departments, assignment is based DutyBoardSlots, but creates
  # DutyBoardAssignements...yeah. Just a mess. I'm sure there's a better way,
  # and eventually, I'll do it that way.
  respond_to :html

  skip_before_action :require_login, only: [:index]

  def index
    @duty_board_groups = policy_scope(DutyBoardGroup).order(:row, :column)
    authorize :duty_board
  end
end
