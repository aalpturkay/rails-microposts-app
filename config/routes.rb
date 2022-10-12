Rails.application.routes.draw do
  get 'sessions/new'
  root "home#index"
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
end
