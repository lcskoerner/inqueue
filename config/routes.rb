Rails.application.routes.draw do
  devise_for :users

  # HOME
  root to: 'pages#home'

  # SEARCH PAGE
  get "places/search", to: "places#search", as: :places_search
  get "places/results", to: "places#results", as: :places_results

  # MAP PAGE
  get "places/map", to: "places#map", as: :places_map

  # SHOW PAGE
  get "places/:id", to: "places#show", as: :place
  # :create, :update

  # LINE PAGE
  # :create, :show, :update

  resources :places, only: [ :create, :update ]  do
    resources :lines, only: [ :create, :show, :update ]
  end
end
