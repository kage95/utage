Rails.application.routes.draw do
  root "homes#top"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end
  resources :users, only: [:show]
  resources :events do
    collection do
      get :confirm, :future, :past, :search, :favorite
    end
    resource :rooms, only: [:show]
    resource :favorites, only: [:create, :destroy]
  end
  resources :restaurants,only: [:index,:new]
  get 'restaurants/search' => 'restaurants#search',as:"search"
  post "events/select_restaurant" => "events#select_restaurant",as:"select_restaurant"
  resources :memberships, only: [:create,:destroy]
  resources :messages, only: [:create]

end
