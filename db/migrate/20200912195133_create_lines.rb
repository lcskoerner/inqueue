class CreateLines < ActiveRecord::Migration[6.0]
  def change
    create_table :lines do |t|
      t.integer :start_time
      t.integer :end_time
      t.integer :date
      t.references :places, null: false, foreign_key: true

      t.timestamps
    end
  end
end
