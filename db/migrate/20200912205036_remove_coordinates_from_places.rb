class RemoveCoordinatesFromPlaces < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :latitude, :float
    remove_column :places, :longitute, :float
  end
end
