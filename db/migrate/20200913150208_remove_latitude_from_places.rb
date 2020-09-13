class RemoveLatitudeFromPlaces < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :latitude, :integer
  end
end
