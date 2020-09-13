class RemoveLongitutudeFromPlaces < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :longitutude, :integer
  end
end
