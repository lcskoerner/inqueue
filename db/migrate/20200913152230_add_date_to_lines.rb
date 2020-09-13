class AddDateToLines < ActiveRecord::Migration[6.0]
  def change
    add_column :lines, :date, :date
  end
end
