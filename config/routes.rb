Rails.application.routes.draw do
  resources :model_pictures
  apipie
  resources :models
  resources :administrators
  post "/admin/auth" => "administrators#login"

  get "/" => "index#index"
end
