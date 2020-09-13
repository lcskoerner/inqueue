class RemovePhotoIdFromPlaces < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :photo_id, :integer
  end
end
