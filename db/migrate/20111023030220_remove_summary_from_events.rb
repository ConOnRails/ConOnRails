# frozen_string_literal: true

class RemoveSummaryFromEvents < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :summary
  end
end
