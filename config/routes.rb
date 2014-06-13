Rails.application.routes.draw do
  resources :invites, path: '/', only: [:create, :show]
  root to: 'invites#new'

  get '/auth/:provider/callback', to: 'sessions#create'
end
