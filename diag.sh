day=$( date +%d )

if [ "$day" = "1" ] || [ "$day" = "21" ]; then
  # add command for diag here =>
  rake model_without_pictures_diag
fi

