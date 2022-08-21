class ModelPicture < ApplicationRecord
  def self.register_picture(picture_path, model_id, is_main_picture, cloudinary_id)
    ModelPicture.create({ picture_path: picture_path, model_uuid: model_id, main_picture: is_main_picture,
                          cloudinary_id: cloudinary_id })
  end

  def self.change_main_picture(picture, model_id)
    last_main_picture = ModelPicture.find_by(model_uuid: model_id, main_picture: true)
    last_main_picture.main_picture = false
    last_main_picture.save
    picture.main_picture = true
    picture.save
  end
end
