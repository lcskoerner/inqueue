Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "places/search", to: "places#search", as: :places_search
  get "places/results", to: "places#results", as: :places_results
  # get "places/:google_place_id/lines", to: "lines#create", as: :place_lines

  resources :places, only: [ :show, :create, :update ]  do
    resources :lines, only: [ :show, :create, :update, :destroy ]
  end
end
