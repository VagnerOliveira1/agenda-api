class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :zip_code
      t.string :street
      t.integer :number
      t.string :district
      t.string :city
      t.string :state
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
