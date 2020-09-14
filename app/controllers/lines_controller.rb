class LinesController < ApplicationController
  def create
  end

  #END LINE (update)
  #PATCH "/lines/:id/" , to: lines#update
  def update
  end
  
  #START LINE (create and show)
  #A.START TIMER WHEN PLACE DOES NOT EXIST:
  #POST "places/:google_places_id/lines", to: "lines#create"
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
