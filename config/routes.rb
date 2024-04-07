Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  resources :articles
  resources :users, except: [:new]
  get "signup", to: "users#new"
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
