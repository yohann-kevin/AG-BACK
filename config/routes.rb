Rails.application.routes.draw do
  apipie
  resources :models
  resources :administrators
  post "/admin/auth" => "administrators#login"

  get "/" => "index#index"
end
