Rails.application.routes.draw do
  root to: "application#index"

  post :contact, action: :create, controller: 'contact'
end
