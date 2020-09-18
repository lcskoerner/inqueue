class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def create
  end

  # GET "/places/search", to: places#search
  def results
    keyword = place_params[:query]
    location = place_params[:location]

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
        @places << place
      end
    end
    html = render_to_string(partial: "places/results", locals:  { places: @places })
    render json: { results_html: html }
  end

  def search
  end

  # GET "/places/:id" , to: places#show
  def show
    @place = Place.find(params[:id])
  end

  private

  def place_params
    params.permit(:query, :location)
  end

end
