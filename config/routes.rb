Rails.application.routes.draw do
  get 'restaurants/search' => 'restaurants#search',as:"search"
  get 'restaurants/index'
  devise_for :users
  root "homes#top"
  resources :users
  resources :events
end
