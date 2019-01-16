class RenameTargetEventField < ActiveRecord::Migration[5.2]
  def change
    rename_column Target, :desc, :description
    rename_column Target, :status, :achieved
    rename_column Event, :desc, :description
  end
end
