class DiagFixModelService
  def model_without_pictures_diag
    all_models = Model.all.select(:id)
    models_id = all_models.map(&:id)
    all_model_pictures = ModelPicture.all
    picture_model_uuid = all_model_pictures.map(&:model_uuid)
    diff_picture_and_model = models_id - picture_model_uuid.uniq
    Model.where(id: diff_picture_and_model)
  end

  def model_without_cloudinary_id_diag
    ModelPicture.where(cloudinary_id: nil)
  end

  def model_without_main_picture_diag
    models = Model.select(:id).all
    models.filter_map do |model|
      model_main_picture = ModelPicture.find_by(model_uuid: model.id, main_picture: true)
      model if model_main_picture.nil?
    end
  end

  def model_without_level
    Model.where(level: nil)
  end

  def model_info_without_model
    all_models_info = ModelInfo.all.select(:model_uuid)
    models_info_model_uuid = all_models_info.map(&:model_uuid)
    all_models = Model.all.select(:id)
    models_id = all_models.map(&:id)
    diff_info_and_model = models_info_model_uuid - models_id
    ModelInfo.where(model_uuid: diff_info_and_model).pluck(:model_uuid)
  end
end
