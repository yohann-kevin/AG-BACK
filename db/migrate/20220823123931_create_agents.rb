class CreateAgents < ActiveRecord::Migration[6.1]
  def change
    create_table :agents do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password
      t.boolean :cgu

      t.timestamps
    end
  end
end
