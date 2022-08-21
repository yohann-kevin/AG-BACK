class DiagFixModelService
  def model_without_pictures_diag
    all_models = Model.all.select(:id)
    models_id = all_models.map { |model| model.id }
    all_model_pictures = ModelPicture.all
    picture_model_uuid = all_model_pictures.map { |picture| picture.model_uuid }
    diff_picture_and_model = models_id - picture_model_uuid.uniq
    Model.where(id: diff_picture_and_model)
  end

  def model_without_cloudinary_id_diag
    ModelPicture.where(cloudinary_id: nil)
  end
end
