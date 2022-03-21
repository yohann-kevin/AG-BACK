class CreateModelNetworks < ActiveRecord::Migration[6.1]
  def change
    create_table :model_networks do |t|
      t.string :model_uuid
      t.string :instagram
      t.string :facebook
      t.string :snapchat
      t.string :tiktok
      t.string :twitter

      t.timestamps
    end
  end
end
