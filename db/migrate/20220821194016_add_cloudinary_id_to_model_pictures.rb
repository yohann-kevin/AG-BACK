class AddCloudinaryIdToModelPictures < ActiveRecord::Migration[6.1]
  def change
    add_column :model_pictures, :cloudinary_id, :string
  end
end
