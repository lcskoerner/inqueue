class RemoveEndTimeFromLines < ActiveRecord::Migration[6.0]
  def change
    remove_column :lines, :end_time, :integer
  end
end
