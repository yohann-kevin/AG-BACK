day=$( date +%d )
env="$(rails runner "puts Rails.env")"
echo "$env"

if [ "$day" = "26" ] || [ "$day" = "27" ]; then
  rake model_without_pictures_diag DIAG_ENV="$env"
  rake picture_without_cloudinary_id_diag DIAG_ENV="$env"
  rake model_without_main_picture_diag DIAG_ENV="$env"
fi
