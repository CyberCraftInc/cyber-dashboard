class AddDefaultValuePosition < ActiveRecord::Migration[5.2]
  def change
    change_column User, :position, :string, default: 'Engineer'
  end
end
