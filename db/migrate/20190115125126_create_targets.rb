class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.string :desc
      t.belongs_to :event, index: true
      t.boolean :status

      t.timestamps
    end
  end
end
