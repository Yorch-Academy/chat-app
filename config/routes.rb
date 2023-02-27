Rails.application.routes.draw do
  post 'add/user', to: 'rooms#add_user'
  resources :rooms
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "rooms#index"
end
