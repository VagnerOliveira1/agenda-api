class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.integer :phone_number
      t.boolean :whatsapp,  default: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
