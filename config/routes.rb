Rails.application.routes.draw do
  resources :invites, only: [:new, :create]
  resources :invites, path: '/', only: [:show]
  root to: 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'
end
