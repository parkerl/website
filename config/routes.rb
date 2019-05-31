Rails.application.routes.draw do
  root to: "application#index"

  post '/', action: :create, controller: 'application'
  resources :blogs, only: [:index]
end
