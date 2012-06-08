class DutyBoardController < ApplicationController
  skip_before_filter :require_login, only: [:index]
  def index
    @departments = Department.all
  end

end
