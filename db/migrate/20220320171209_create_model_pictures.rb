class CreateModelPictures < ActiveRecord::Migration[6.1]
  def change
    create_table :model_pictures do |t|
      t.string :model_uuid
      t.string :picture_path
      t.boolean :main_picture

      t.timestamps
    end
  end
end
