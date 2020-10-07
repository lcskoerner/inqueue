class PlacesController < ApplicationController
  def create
    google_place_id = params[:place][:google_place_id]
    distance = params[:distance]
    fields = 'name,formatted_address,geometry,place_id,rating,formatted_phone_number,business_status,price_level,vicinity,types'
    url = 'https://maps.googleapis.com/maps/api/place/details/json?'
    resp = Faraday.get(url, { place_id: google_place_id, fields: fields, key: ENV['GOOGLE_API_KEY'] }, { 'Accept' => 'application/json' })
    place = JSON.parse(resp.body)['result']
    @place = Place.find_or_initialize_by(google_place_id: place['place_id'])
    if @place.new_record?
      @place.name = place['name']
      @place.address = place['formatted_address']
      @place.latitude = place['geometry']['location']['lat']
      @place.longitude = place['geometry']['location']['lng']
      @place.rating = place['rating']
      @place.phone_number = place['formatted_phone_number']
      @place.vicinity = place['vicinity']
      @place.place_type = place['types'].first.gsub("_", " ").capitalize
      @place.save!
    end
    redirect_to place_path(@place, { distance: distance })
  end

  def results
    keyword = place_params[:query]
    location = place_params[:location]
    map = place_params[:map] == "true"
    @colors = { white: "white", green: "#D8FFD8", orange: "#FCC97D", red: "#F1A298" }
    @places = []

    @places = search_google(keyword, location) unless keyword.nil? || keyword.empty?

    if map
      @markers = @places.map do |place|
        {
          lat: place.first.latitude,
          lng: place.first.longitude,
          title: place.first.name,
          address: place.first.address,
          distance: place.second,
          google_place_id: place.first.google_place_id,
          label: place.first.last_line.nil? ? "no lines" : "#{place.first.last_line} min",
          icon: ActionController::Base.helpers.image_path("#{helpers.set_color(place.first.last_line)}.png")
          # infoWindow: { content: render_to_string(partial: "/places/infoWindow", locals: { place: place }) }
          # Uncomment the above line if you want each of your markers to display a info window when clicked
          # (you will also need to create the partial "/flats/map_box")
        }
      end
      html = render_to_string(partial: "places/map", locals: { places: @places, markers: @markers })
    else
      html = render_to_string(partial: "places/results", locals: { places: @places, colors: @colors })
    end

    render json: { results_html: html }
  end

  def search_google(keyword, location)
    url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
    resp = Faraday.get(url, { query: keyword, location: location, key: ENV['GOOGLE_API_KEY'] }, { 'Accept' => 'application/json' })
    results = JSON.parse(resp.body)['results']
    results.each do |res|
      place = Place.find_or_initialize_by(google_place_id: res['place_id'])
      if place.new_record?
        place.name = res['name']
        place.address = res['formatted_address']
        place.latitude = res['geometry']['location']['lat']
        place.longitude = res['geometry']['location']['lng']
        place.rating = res['rating']
        place.place_type = res['types'].first.gsub("_", " ").capitalize
      end
      distance = "#{place.distance_to(location.split(",")).round(1)} km"
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
    @distance = params[:distance]
    @line = Line.new
  end

  private

  def place_params
    params.permit(:query, :location, :map)
  end
end
