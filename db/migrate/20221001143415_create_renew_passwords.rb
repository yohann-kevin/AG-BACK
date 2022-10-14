class CreateRenewPasswords < ActiveRecord::Migration[6.1]
  def change
    create_table :renew_passwords do |t|
      t.string :agent_id
      t.string :secure_id
      t.string :agent_email
      t.boolean :active

      t.timestamps
    end
  end
end
