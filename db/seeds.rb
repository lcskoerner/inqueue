require 'json'
require 'open-uri'

Line.destroy_all
puts "Cleaning the lines"
Place.destroy_all
puts "Cleaning the places"
User.destroy_all
puts "Cleaning the users"

def seed_place_information(place_id)
  fields = 'name,formatted_address,geometry,place_id,rating,formatted_phone_number,business_status,price_level,vicinity,types'
  endpoint = 'https://maps.googleapis.com/maps/api/place/details/json?'
  url = "#{endpoint}place_id=#{place_id}&fields=#{fields}&key=#{ENV['GOOGLE_API_KEY']}"
  place_serialized = open(url).read
  p = JSON.parse(place_serialized)['result']

  Place.new(
    name: p['name'],
    address: p['formatted_address'],
    latitude: p['geometry']['location']['lat'],
    longitude: p['geometry']['location']['lng'],
    rating: p['rating'],
    google_place_id: p['place_id'],
    phone_number: p['formatted_phone_number'],
    vicinity: p['vicinity'],
    place_type: p['types'].first.gsub("_", " ").capitalize
    )
end

def seed_line_information(place, extension, user)
  Line.new(
    start_date: DateTime.now,
    end_date: DateTime.now + extension.minutes,
    active: false,
    place: place,
    user: user
    )
end

user = User.new(
  email: ENV['VISITOR_EMAIL'],
  password: ENV['VISITOR_PASSWORD']
  )

user.save!

filepath = 'db/places.json'
serialized_places = File.read(filepath)
places = JSON.parse(serialized_places)['results']

places.each do |p|
  place_id = p['place_id']
  place = seed_place_information(place_id)
  line = seed_line_information(place, rand(25..45), user)
  line.save!
  place.last_line = ((line.end_date - line.start_date) / 60).to_i
  place.save!

  puts "place #{place.id} – #{place.name} – #{place.address} created!"
  puts "#{place.name} – last line: #{place.last_line} min"
end

puts "seed finished!"
