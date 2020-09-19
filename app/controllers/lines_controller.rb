class LinesController < ApplicationController
  def new
  end

  def create
    @place = Place.find(params[:place_id])
    @line = Line.new
    @line.start_date = Time.now
    @line.place = @place
    @line.save!
    puts @place.attributes
    puts @line.attributes
    flash[:notice] = "line started"
    redirect_to place_path(@place)
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
