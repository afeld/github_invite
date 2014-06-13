Rails.application.routes.draw do
  resources :invites

  get '/auth/:provider/callback', to: 'sessions#create'
end
