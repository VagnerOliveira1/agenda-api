class RemoveColumnWhatsappFromPhones < ActiveRecord::Migration[6.1]
  def change
    remove_column :phones, :whatsapp
  end
end
