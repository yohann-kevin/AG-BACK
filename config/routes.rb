Rails.application.routes.draw do
  resources :administrators
  post "/admin/auth" => "administrators#login"

  get "/" => "index#index"
end
