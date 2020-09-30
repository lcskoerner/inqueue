class AddPhoneNumberToPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :phone_number, :string
  end
end
