Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  root to: "pages#home"

  resources :venues do
    resources :bookings, only: %i[new create]
    resources :reviews, only: %i[index show new]
  end
  # As a renter I can see all existing bookings
  resources :bookings, only: [:index]
  resources :bookings, only: [:destroy]
end
