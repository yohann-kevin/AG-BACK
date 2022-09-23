day=$( date +%d )
env="$(rails runner "puts Rails.env")"
noday="$1"

echo "$env"

launch_comand () {
  rake model_without_pictures_diag DIAG_ENV="$env"
  rake picture_without_cloudinary_id_diag DIAG_ENV="$env"
  rake model_without_main_picture_diag DIAG_ENV="$env"
  rake picture_not_delete_in_cloudinary_diag DIAG_ENV="$env"
}

if [ "$noday" = "--no-day" ]; then
  launch_comand
elif [ "$day" = "1" ] || [ "$day" = "15" ]; then
  launch_comand
fi
