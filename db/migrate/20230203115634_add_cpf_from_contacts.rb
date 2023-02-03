class AddCpfFromContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :cpf, :string
  end
end
