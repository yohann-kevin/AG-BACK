Rails.application.routes.draw do
  resources :models
  resources :administrators
  post "/admin/auth" => "administrators#login"

  get "/" => "index#index"
end
