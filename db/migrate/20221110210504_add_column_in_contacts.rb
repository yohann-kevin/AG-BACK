class AddColumnInContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :phone, :string
    add_column :contacts, :company, :string
    add_column :contacts, :activity, :string
    add_column :contacts, :need, :string
  end
end
