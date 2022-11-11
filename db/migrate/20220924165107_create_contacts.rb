class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :destinator
      t.string :sender
      t.string :object
      t.text :content

      t.timestamps
    end
  end
end
