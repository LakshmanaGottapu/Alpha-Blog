Rails.application.routes.draw do
  root "application#index"
  get "home", to: "pages#home"
  get "about", to: "pages#about"
  resources :articles, only: [:show]
end
