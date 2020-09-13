class RemoveDateFromLines < ActiveRecord::Migration[6.0]
  def change
    remove_column :lines, :date, :integer
  end
end
