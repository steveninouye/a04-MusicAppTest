Rails.application.routes.draw do
  resources :tracks
  resources :albums
  resources :bands
  resources :bands, only: [] do
    resources :albums, only: [:new]
  end
  resources :bands
  resources :users
  resource :session
end
