class AuditsController < ApplicationController
  private
  def make_date(date_array)
    p date_array
    return Time.local(date_array["item(1i)"].to_i,
                      date_array["item(2i)"].to_i,
                      date_array["item(3i)"].to_i,
                      date_array["item(4i)"].to_i,
                      date_array["item(5i)"].to_i)
  end

  public

  def index
    start_date = Time.now.years_ago 3
    end_date   = Time.now.years_since 3
    start_date = make_date(params[:start_date]) if params[:use_start_date] and params[:start_date]
    end_date = make_date(params[:end_date]) if params[:use_end_date] and params[:end_date]
    p start_date
    @audits = Audit.where(created_at: (start_date..end_date)).page(params[:page])
  end

end
