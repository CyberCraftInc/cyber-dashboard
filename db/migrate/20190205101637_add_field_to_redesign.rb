class AddFieldToRedesign < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :position
      t.date :birthday
      t.date :start_in_company
    end
  end
end
