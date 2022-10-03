Rails.application.routes.draw do
  root "home#index"
  get '/signup', to: 'users#new'
  resources :users
end
