Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  get "forbidden", to: "pages#forbidden"
  resources :articles
  resources :users, except: [:new]
  get "signup", to: "users#new"
  get "login", to: "session#new"
  post "login", to: "session#create"
  get "logout", to: "session#destroy"
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  # root "posts#index"
end
