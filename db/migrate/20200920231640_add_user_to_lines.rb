class AddUserToLines < ActiveRecord::Migration[6.0]
  def change
    add_reference :lines, :user, foreign_key: true
  end
end
