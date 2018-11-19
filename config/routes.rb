Rails.application.routes.draw do
  resources :tracks
  resources :albums
  resources :bands
  resources :users
  resource :session
end
