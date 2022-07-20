Rails.application.routes.draw do
  resources :model_networks
  resources :model_infos

  resources :model_pictures
  post "/model_pictures/modify/main_picture" => "model_pictures#modify_main_picture"

  apipie
  resources :models
  resources :administrators
  post "/admin/auth" => "administrators#login"

  # endpoint for model
  get "/get/all/model" => "mannequin#home_model_data"
  get "/get/model/:id" => "mannequin#all_model_data"
  post "/create/model" => "mannequin#add_model_data"
  post "/modify/model" => "mannequin#update_model"
  delete "/delete/model" => "mannequin#delete_model"

  get "/" => "index#index"
end
