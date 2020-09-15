# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

filepath = 'db/places.json'
serialized_places = File.read(filepath)
places = JSON.parse(serialized_places)
places = places['results']

places.each_with_index  do |p,i|
  place = Place.new(
    name: p['name'],
    address: p['formatted_address'],
    rating: p['rating'],
    google_place_id: p['place_id']
  )
  place.save!
  puts "place #{i + 1} created!"
end

puts "seed finished!"
