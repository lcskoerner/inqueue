class AddEndTimeToLines < ActiveRecord::Migration[6.0]
  def change
    add_column :lines, :end_time, :date
  end
end
