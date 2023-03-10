Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :tweets, only: [:show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    resources :retweets, only: [:create, :destroy]
  end

  get '/dashboard', to: 'dashboard#index'

  resources :usernames, only: [ :new, :update ]
end
