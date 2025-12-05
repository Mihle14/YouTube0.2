Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :channels, only: [:new, :create, :show, :edit, :update] do
    resources :subscriptions, only: [:create, :destroy]
  end
  
  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
