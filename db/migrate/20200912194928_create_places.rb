class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.text :address
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :rating
      t.string :google_place_id
      t.timestamps
    end
  end
end
