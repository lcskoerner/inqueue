Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "places/search", to: "places#search", as: :places_search

  resources :places, only: [ :show ]  do
    resources :lines, only: [ :create, :show, :update, :destroy ]
  end
end
