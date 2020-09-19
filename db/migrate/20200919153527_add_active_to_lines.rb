class AddActiveToLines < ActiveRecord::Migration[6.0]
  def change
    add_column :lines, :active, :boolean
  end
end
