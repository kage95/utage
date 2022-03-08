Rails.application.routes.draw do
  get 'restaurants/search' => 'restaurants#search',as:"search"
  devise_for :users
  root "homes#top"
  resources :users
  resources :events
  resources :restaurants,only: [:index,:new]
end
