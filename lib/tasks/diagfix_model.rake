require "net/http"
require "json"

desc "diag check if model have a picture"
task model_without_pictures_diag: :environment do
  model_without_picture = DiagFixModelService.new.model_without_pictures_diag

  if model_without_picture.size === 0
    message = "All modeles have a picture"
    DiscordDiagService.new("model_without_pictures_diag", message, false).send_diag_result
  else
    message = "#{model_without_picture.size} Modeles not have a picture. Fix required !"
    DiscordDiagService.new("model_without_pictures_diag", message, true, model_without_picture).send_diag_result
  end
end

desc "fix model not have a picture"
task model_without_pictures_fix: :environment do
  model_without_picture = DiagFixModelService.new.model_without_pictures_diag

  model_without_picture.each do |model|
    Model.delete(model.id)
  end
end

desc "diag check if all picture have a cloudinary id"
task picture_without_cloudinary_id_diag: :environment do
  picture_without_cloudinary_id = DiagFixModelService.new.model_without_cloudinary_id_diag

  if picture_without_cloudinary_id.size === 0
    message = "All picture have a cloudinary_id"
    DiscordDiagService.new("picture_without_cloudinary_id_diag", message, false).send_diag_result
  else
    message = "#{picture_without_cloudinary_id.size} Picture not have a public_id. Fix required !"
    DiscordDiagService.new("picture_without_cloudinary_id_diag", message, true).send_diag_result
  end
end

desc "fix add cloudinary id to picture"
task picture_without_cloudinary_id_fix: :environment do
  picture_without_cloudinary_id = DiagFixModelService.new.model_without_cloudinary_id_diag

  picture_without_cloudinary_id.each do |picture|
    picture_name = picture[:picture_path].split("/").last
    public_id = picture_name.split(".").first
    picture.cloudinary_id = public_id
    picture.save
  end
end

desc "diag check if all model have a main picture"
task model_without_main_picture_diag: :environment do
  model_without_main_picture = DiagFixModelService.new.model_without_main_picture_diag

  if model_without_main_picture.size === 0
    message = "All model have a main picture"
    DiscordDiagService.new("model_without_main_picture_diag", message, false).send_diag_result
  else
    message = "#{model_without_main_picture.size} Model not have a main picture. Fix required !"
    DiscordDiagService.new("model_without_main_picture_diag", message, true,
                           model_without_main_picture).send_diag_result
  end
end

desc "fix remove model without main picture"
task model_without_main_picture_fix: :environment do
  model_without_main_picture = DiagFixModelService.new.model_without_main_picture_diag

  model_without_main_picture.each do |model|
    ModelNetwork.find_by(model_uuid: model.id).delete
    ModelInfo.find_by(model_uuid: model.id).delete
    model.delete
  end
end

desc "diag check picture not delete in cloudinary"
task picture_not_delete_in_cloudinary_diag: :environment do
  picture_not_delete = CloudinaryService.new.find_picture_not_delete

  if picture_not_delete.size === 0
    message = "All picture is okay on cloudinary"
    DiscordDiagService.new("picture_not_delete_in_cloudinary_diag", message, false).send_diag_result
  else
    message = "#{picture_not_delete.size} Picture not delete in cloudinary. Fix required !"
    DiscordDiagService.new("picture_not_delete_in_cloudinary_diag", message, true).send_diag_result
  end
end

desc "fix remove model without main picture"
task picture_not_delete_in_cloudinary_fix: :environment do
  picture_not_delete = CloudinaryService.new.find_picture_not_delete

  picture_not_delete.each do |picture_id|
    CloudinaryService.new.destroy_model_image(picture_id)
  end
end

desc "diag check if all model have a level"
task model_not_have_level_diag: :environment do
  model_not_have_level = DiagFixModelService.new.model_without_level

  if model_not_have_level.size === 0
    message = "All model have a level"
    DiscordDiagService.new("model_not_have_level_diag", message, false).send_diag_result
  else
    message = "#{model_not_have_level.size} model not have a level. Fix required !"
    DiscordDiagService.new("model_not_have_level_diag", message, true).send_diag_result
  end
end

desc "fix check if all model have a level"
task model_not_have_level_fix: :environment do
  model_not_have_level = DiagFixModelService.new.model_without_level

  model_not_have_level.each do |model|
    model.level = "T7"
    model.save
  end
end
