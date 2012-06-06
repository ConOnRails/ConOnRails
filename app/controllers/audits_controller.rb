class AuditsController < ApplicationController
  def index
    start = ""
    if params[:start_date]
      start = DateTime.new(params[:start_date]["item(1i)"].to_i,
                           params[:start_date]["item(2i)"].to_i,
                           params[:start_date]["item(3i)"].to_i,
                           params[:start_date]["item(4i)"].to_i,
                           params[:start_date]["item(5i)"].to_i,
                           DateTime.local_offset)
      p start
    end
    @audits = Audit.where( "created_at >= :start_date", { start_date: params[:start_date]} ).page(params[:page])
  end

end
