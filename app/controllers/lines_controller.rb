class LinesController < ApplicationController
  def create
    @place = Place.find_by google_place_id: params[:google_place_id]
    @place.save!
    @line = Line.new(
      start_date: Time.now,
      date: Date.today,
    )
    @line.place = @place
    @line.save!
    puts @place.attributes
    puts @line.attributes
  end

  #END LINE (update)
  #PATCH "/lines/:id/" , to: lines#update
  def update
  end

  #START LINE (create and show)
  #A.START TIMER WHEN PLACE DOES NOT EXIST:
  #POST "places/:google_place_id/lines", to: "lines#create"
  #GET "/lines/:id/" , to: lines#show
  #B.START TIMER WHEN PLACE ALREADY EXIST:
  #POST "places/:place_id/lines", to: "lines#create"
  #GET "/lines/:id/" , to: lines#show
  def show
  end

  #QUIT LINE(destroy)
  #DELETE "/lines/:id/" , to: lines#destroy
  def destroy
  end
end
