class AddVicinityToPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :vicinity, :string
  end
end
