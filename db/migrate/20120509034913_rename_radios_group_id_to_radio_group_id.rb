# frozen_string_literal: true

class RenameRadiosGroupIdToRadioGroupId < ActiveRecord::Migration
  def up
    rename_column :radios, :group_id, :radio_group_id
  end

  def down
    rename_column :radios, :radio_group_id, :group_id
  end
end
