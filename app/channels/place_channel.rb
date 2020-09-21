class PlaceChannel < ApplicationCable::Channel
  def subscribed
    place = Place.find(params[:id])
    stream_for place
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
