# == Schema Information
#
# Table name: audits
#
#  id              :integer          not null, primary key
#  auditable_id    :integer
#  auditable_type  :string(255)
#  associated_id   :integer
#  associated_type :string(255)
#  user_id         :integer
#  user_type       :string(255)
#  username        :string(255)
#  action          :string(255)
#  audited_changes :text
#  version         :integer          default(0)
#  comment         :string(255)
#  remote_address  :string(255)
#  created_at      :datetime
#

class AuditsController < ApplicationController
  before_filter :get_audits, only: :index
  load_and_authorize_resource

  private
  def make_date(date_array)
    return Time.local(date_array["item(1i)"].to_i,
                      date_array["item(2i)"].to_i,
                      date_array["item(3i)"].to_i,
                      date_array["item(4i)"].to_i,
                      date_array["item(5i)"].to_i)
  end

  protected

  def get_audits
    # TODO This routine needs an enema...er...refactor. Bad.

    start_date = Time.now.years_ago 3
    end_date   = Time.now.years_since 3
    start_date = make_date(params[:start_date]) if params[:use_start_date]
    end_date = make_date(params[:end_date]) if params[:use_end_date]
    w = {}
    w[:created_at] = (start_date..end_date)

    types = []
    types << ["Event", "Entry"] if params[:events]
    types  << "LostAndFoundItem" if params[:lfi]

    w[:auditable_type] = types unless types.count == 0

    @audits = Audit.where(w).page(params[:page])
  end

end
