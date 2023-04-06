Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :tweets, only: [:show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    resources :retweets, only: [:create, :destroy]
    resources :reply_tweets, only: [:create]
  end

  resources :bookmarks, only: :index
  resources :hashtags, only: [:index, :show], path: 'explore'
  resources :message_threads, only: :index, path: 'messages'

  get '/dashboard', to: 'dashboard#index'
  get '/profile', to: 'profiles#show'
  put '/profile', to: 'profiles#update'

  resources :usernames, only: [ :new, :update ]
  resources :users, only: :show do
    resources :followings, only: [ :create, :destroy]
  end
end
