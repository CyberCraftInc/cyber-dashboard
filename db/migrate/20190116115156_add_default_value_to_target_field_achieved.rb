class AddDefaultValueToTargetFieldAchieved < ActiveRecord::Migration[5.2]
  def change
    change_column Target, :achieved, :boolean, default: false
  end
end
