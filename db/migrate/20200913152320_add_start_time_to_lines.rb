class AddStartTimeToLines < ActiveRecord::Migration[6.0]
  def change
    add_column :lines, :start_time, :date
  end
end
