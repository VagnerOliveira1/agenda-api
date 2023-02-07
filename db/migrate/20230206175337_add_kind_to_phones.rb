class AddKindToPhones < ActiveRecord::Migration[6.1]
  def change
    add_column :phones, :kind, :integer
  end
end
