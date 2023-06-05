class AddCloudinaryIdToArticlePicture < ActiveRecord::Migration[6.1]
  def change
    add_column :article_pictures, :cloudinary_id, :string
  end
end
