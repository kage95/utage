Rails.application.routes.draw do
  root "homes#top"
  devise_for :users
  resources :users
  resources :events do
    collection do
      get :confirm
    end
  end
  resources :restaurants,only: [:index,:new]
  get 'restaurants/search' => 'restaurants#search',as:"search"
  post "events/select_restaurant" => "events#select_restaurant",as:"select_restaurant"
  resources :memberships, only: [:create,:destroy]
end
