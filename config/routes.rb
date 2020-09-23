Rails.application.routes.draw do
  devise_for :users

  # HOME
  root to: 'pages#home'

  # SEARCH PAGE
  get "places/search", to: "places#search", as: :places_search
  get "places/results", to: "places#results", as: :places_results

  # MAP PAGE
  get "places/map", to: "places#map", as: :places_map


  resources :places, only: [ :show, :create, :update ]  do
    resources :lines, only: [ :show, :create, :update, :destroy ]
  end
end
