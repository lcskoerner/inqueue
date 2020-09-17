class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  # GET "/places/search", to: places#search
  def search
    keyword = params[:query]
    location = params[:location]

    @places = []

    unless keyword.nil? || keyword.empty?
      url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
      resp = Faraday.get(url, {query: keyword, location: location, key: ENV['GOOGLE_API_KEY']}, {'Accept' => 'application/json'})
      results = JSON.parse(resp.body)['results']
      results.each do |result|
        place = Place.new(
          name: result['name'],
          address: result['formatted_address'],
          latitude: result['geometry']['location']['lat'],
          longitude: result['geometry']['location']['lng'],
          rating: result['rating'],
          google_place_id: result['place_id']
        )
        place.save!
        @places << place
      end
      render json: @places.map(&:attributes)
    end
  end

  # GET "/places/:id" , to: places#show
  def show
    @place = Place.find(params[:id])
  end
end
