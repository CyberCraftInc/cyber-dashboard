class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :desc
      t.date :start_date
      t.date :finish_date
      t.text :comments
      t.text :summary
      t.belongs_to :user, index: true
      t.column :status, :integer, default: 0

      t.timestamps
    end
  end
end
