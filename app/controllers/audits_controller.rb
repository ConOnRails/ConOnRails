# frozen_string_literal: true

class AuditsController < ApplicationController
  private

  def make_date(date_array)
    Time.zone.local(date_array['item(1i)'].to_i,
                    date_array['item(2i)'].to_i,
                    date_array['item(3i)'].to_i,
                    date_array['item(4i)'].to_i,
                    date_array['item(5i)'].to_i)
  end

  public

  def index
    # TODO: This routine needs an enema...er...refactor. Bad.

    start_date = Time.zone.now.years_ago 3
    end_date   = Time.zone.now.years_since 3
    start_date = make_date(params[:start_date]) if params[:use_start_date]
    end_date = make_date(params[:end_date]) if params[:use_end_date]
    w = {}
    w[:created_at] = (start_date..end_date)

    types = []
    types << %w[Event Entry] if params[:events]
    types << 'LostAndFoundItem' if params[:lfi]

    w[:auditable_type] = types unless types.count == 0

    @audits = policy_scope(Audit).where(w).page(params[:page])
    authorize @audits
  end
end
