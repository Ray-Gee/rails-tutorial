# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # post "/signup", to: "users#create"
  # get "sessions/new"
  # get "users/new"
  # get '/home', to: 'static_pages#home'
  resources :users do
    collection { post :csv_import }
  end
end
