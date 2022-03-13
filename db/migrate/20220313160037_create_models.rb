class CreateModels < ActiveRecord::Migration[6.1]
  def change
    create_table :models do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :address
      t.datetime :birth_date

      t.timestamps
    end
  end
end
