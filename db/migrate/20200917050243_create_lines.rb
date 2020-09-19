class CreateLines < ActiveRecord::Migration[6.0]
  def change
    create_table :lines do |t|
      t.date :start_date
      t.date :end_date
      t.date :date
      t.references :place, null: false, foreign_key: true
    end
  end
end
