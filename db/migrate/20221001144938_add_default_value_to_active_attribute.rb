class AddDefaultValueToActiveAttribute < ActiveRecord::Migration[6.1]
  def change
    change_column :renew_passwords, :active, :boolean, default: true
  end
end
