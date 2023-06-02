Rails.application.routes.draw do
 
  mount HygieBackRunner::Engine => "/hygie_back_runner"

  resources :contacts
  resources :articles
  resources :model_networks
  resources :model_infos
  resources :article_pictures
  post "article_pictures/modify_picture" => "article_pictures#modify_main_picture"

  resources :renew_passwords
  get "/renew_passwords/check/secure_id/:secure_id" => "renew_passwords#check_secure_id"
  post "/renew_passwords/renew/password/:secure_id" => "renew_passwords#renew_password"

  resources :model_pictures
  post "/model_pictures/modify/main_picture" => "model_pictures#modify_main_picture"

  resources :agents
  post "/agent/auth" => "agents#login"
  put "/agent/update/password/:id" => "agents#update_password"

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
