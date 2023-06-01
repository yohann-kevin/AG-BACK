class CreateArticlePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :article_pictures do |t|
      t.string :article_id
      t.string :picture_path
      t.boolean :main_picture
      
      t.timestamps
    end
  end
end
