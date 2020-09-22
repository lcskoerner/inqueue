class ChangeDateToDateTimeToLines < ActiveRecord::Migration[6.0]
  def change
    change_column :lines, :start_date, :datetime
    change_column :lines, :end_date, :datetime
  end
end
