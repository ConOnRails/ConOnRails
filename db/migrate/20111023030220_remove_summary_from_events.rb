# frozen_string_literal: true

class RemoveSummaryFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :summary
  end
end
