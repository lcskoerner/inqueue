class RemoveStartTimeFromLines < ActiveRecord::Migration[6.0]
  def change
    remove_column :lines, :start_time, :integer
  end
end
