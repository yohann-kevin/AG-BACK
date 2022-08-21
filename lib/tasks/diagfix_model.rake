desc "diag check if model have a picture"
task model_without_pictures_diag: :environment do
  model_without_picture = DiagFixModelService.new().model_without_pictures_diag

  if model_without_picture.size === 0
    message = 'All modeles have a picture'
    DiscordDiagService.new('model_without_pictures_diag', message, false).send_diag_result
  else
    message = "#{model_without_picture.size} Modeles not have a picture. Fix required !"
    DiscordDiagService.new('model_without_pictures_diag', message, true, model_without_picture).send_diag_result
  end
end

desc "fix model not have a picture"
task model_without_pictures_fix: :environment do
  model_without_picture = DiagFixModelService.new().model_without_pictures_diag

  model_without_picture.each do |model|
    Model.delete(model.id)
  end
end

desc "diag check if all picture have a cloudinary id"
task picture_without_cloudinary_id_diag: :environment do
  picture_without_cloudinary_id = DiagFixModelService.new().model_without_cloudinary_id_diag

  if picture_without_cloudinary_id.size === 0
    message = 'All picture have a cloudinary_id'
    DiscordDiagService.new('picture_without_cloudinary_id_diag', message, false).send_diag_result
  else
    message = "#{picture_without_cloudinary_id.size} Picture not have a public_id. Fix required !"
    DiscordDiagService.new('picture_without_cloudinary_id_diag', message, true).send_diag_result
  end
end

desc "fix add cloudinary id to picture"
task picture_without_cloudinary_id_fix: :environment do
  picture_without_cloudinary_id = DiagFixModelService.new().model_without_cloudinary_id_diag

  picture_without_cloudinary_id.each do |picture|
    picture_name = picture[:picture_path].split('/').last
    public_id = picture_name.split('.').first
    picture.cloudinary_id = public_id
    picture.save
  end
end
