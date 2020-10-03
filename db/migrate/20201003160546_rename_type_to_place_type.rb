class RenameTypeToPlaceType < ActiveRecord::Migration[6.0]
  def change
    rename_column :places, :type, :place_type
  end
end
