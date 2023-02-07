class AddPhoneNumberFromPhones < ActiveRecord::Migration[6.1]
  def change
    add_column :phones, :phone_number, :string
  end
end
