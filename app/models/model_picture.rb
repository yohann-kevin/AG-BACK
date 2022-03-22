class ModelPicture < ApplicationRecord
  def self.register_picture(picture_path, model_id, is_main_picture)
    ModelPicture.create({ picture_path: picture_path, model_uuid: model_id, main_picture: is_main_picture })
  end
end
