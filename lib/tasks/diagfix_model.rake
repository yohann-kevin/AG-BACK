desc "check if model have a picture"
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

  model_without_picture.each do
    |model|
    Model.delete(model.id)
  end
end
