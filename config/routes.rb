Rails.application.routes.draw do
  resources :administrators
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get "/" => "index#index"
end
