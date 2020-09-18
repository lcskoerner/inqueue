class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def create
    google_place_id = params[:place][:google_place_id]
    fields = 'name,formatted_address,geometry,place_id'
    url = 'https://maps.googleapis.com/maps/api/place/details/json?'
    resp = Faraday.get(url, { place_id: google_place_id, fields: fields, key: ENV['GOOGLE_API_KEY'] }, {'Accept' => 'application/json'})
    place = JSON.parse(resp.body)['result']
    @place = Place.find_or_initialize_by(google_place_id: place['place_id'])
    if @place.new_record?
      @place.name = place['name']
      @place.address = place['formatted_address']
      @place.latitude = place['geometry']['location']['lat']
      @place.longitude = place['geometry']['location']['lng']
      @place.rating = place['rating']
      @place.save!
    else
    end
    flash[:notice] = "place saved"
    render "places/search"
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
