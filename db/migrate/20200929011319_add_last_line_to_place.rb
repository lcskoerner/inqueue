class AddLastLineToPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :last_line, :integer
  end
end
