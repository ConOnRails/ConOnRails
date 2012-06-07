class DutyBoardController < ApplicationController
  def index
    @departments = Department.all
  end

end
