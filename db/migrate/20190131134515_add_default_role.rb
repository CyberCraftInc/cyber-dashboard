class AddDefaultRole < ActiveRecord::Migration[5.2]
  def change
    change_column User, :role, :integer, default: 1
  end
end
