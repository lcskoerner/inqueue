class PlacesController < ApplicationController
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
    end
    redirect_to place_path(@place)
  end

  def results
    puts params
    keyword = place_params[:query]
    location = place_params[:location]
    map = false

    @places = []
    @places = search_google(keyword, location) unless keyword.nil? || keyword.empty?

    if map
      @markers = @places.map do |place|
        {
          lat: place.first.latitude,
          lng: place.first.longitude
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          # Uncomment the above line if you want each of your markers to display a info window when clicked
          # (you will also need to create the partial "/flats/map_box")
        }
      end
      html = render_to_string(partial: "places/map", locals: { places: @places, markers: @markers })
    else
      html = render_to_string(partial: "places/results", locals: { places: @places })
    end

    render json: { results_html: html }
  end

  def search_google(keyword, location)
    url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
    resp = Faraday.get(url, { query: keyword, location: location, key: ENV['GOOGLE_API_KEY'] }, { 'Accept' => 'application/json' })
    results = JSON.parse(resp.body)['results']
    results.each do |res|
      url = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
      resp = Faraday.get(url, { origins: location, destinations: "place_id:#{res['place_id']}", key: ENV['GOOGLE_API_KEY'] }, { 'Accept' => 'application/json' })
      distance = JSON.parse(resp.body)['rows'].first['elements'].first['distance']['text']
      place = Place.find_or_initialize_by(google_place_id: res['place_id'])
      if place.new_record?
        place.name = res['name']
        place.address = res['formatted_address']
        place.latitude = res['geometry']['location']['lat']
        place.longitude = res['geometry']['location']['lng']
        place.rating = res['rating']
      end
      @places << [place, distance]
    end
    return @places
  end

  def search
  end

  def update
    create
  end

  def show
    @place = Place.find(params[:id])
    @line = Line.new
  end

  private

  def place_params
    params.permit(:query, :location)
  end
end
