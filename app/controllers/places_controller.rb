class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  # GET "/places/search", to: places#search
  def search
  end
  
  # GET "/places/:id" , to: places#show
  def show
    @place = Place.find(params[:id])
  end
end
