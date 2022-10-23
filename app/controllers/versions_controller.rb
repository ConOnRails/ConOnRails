# frozen_string_literal: true

class VersionsController < ApplicationController
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
    w = {}
    w[:created_at] = (start_date..end_date)
    w[:item_type] = types unless types.count.zero?

    @versions = policy_scope(Version).where(w).page(params[:page])
    authorize @versions
  end
end

def start_date
  if params[:use_start_date]
    make_date(params[:start_date])
  else
    Time.zone.now.years_ago(3)
  end
end

def end_date
  if params[:use_end_date]
    make_date(params[:end_date])
  else
    Time.zone.now.years_since(3)
  end
end

def types
  types = []
  types << %w[Event Entry] if params[:events]
  types << 'LostAndFoundItem' if params[:lfi]
  types
end
