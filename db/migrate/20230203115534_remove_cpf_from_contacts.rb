class RemoveCpfFromContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :contacts, :cpf, :integer
  end
end
