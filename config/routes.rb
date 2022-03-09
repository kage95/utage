Rails.application.routes.draw do
  get 'restaurants/search' => 'restaurants#search',as:"search"
  devise_for :users
  root "homes#top"
  resources :users
  resources :events do
    collection do
      get :confirm
    end
  end
  resources :restaurants,only: [:index,:new]
  post "events/select_restaurant" => "events#select_restaurant",as:"select_restaurant"
  get "events/confirm" => "events#confirm",as:"confirm"
end
