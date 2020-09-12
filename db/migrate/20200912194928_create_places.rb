class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.text :address
      t.string :name
      t.integer :latitude
      t.integer :longitutude
      t.integer :rating
      t.string :google_place_id
      t.string :photo_id

      t.timestamps
    end
  end
end
