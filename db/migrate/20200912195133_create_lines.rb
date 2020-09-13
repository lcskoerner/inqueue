class CreateLines < ActiveRecord::Migration[6.0]
  def change
    create_table :lines do |t|
      t.date :start_time
      t.date :end_time
      t.date :date
      t.references :places, null: false, foreign_key: true

      t.timestamps
    end
  end
end
