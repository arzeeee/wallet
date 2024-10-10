Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"
  get "dashboard" => "pages#dashboard"
  get "login" => "sessions#new"
  post "auth" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "register" => "users#new"
  post "register" => "users#create"
  get "users/stocks" => "users#stocks"

  resources :transactions do
    collection do
      post :deposit
      post :withdraw
      post :transfer
    end
  end

  namespace :stocks do
    get :price
    get :prices
    get :price_all
    get :update_prices
    get :purchase
    post :buy_stock
    get :sell
    post :sell_stock
  end
end
