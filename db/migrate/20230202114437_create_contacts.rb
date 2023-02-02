class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.integer :cpf
      t.string :email
      t.datetime :birth_date

      t.timestamps
    end
  end
end
