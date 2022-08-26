day=$( date +%d )

if [ "$day" = "1" ] || [ "$day" = "21" ]; then
  # add command for diag here =>
  rake model_without_pictures_diag
  rake picture_without_cloudinary_id_diag
fi

