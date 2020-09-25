class LinesController < ApplicationController
  def new
  end

  def create
    @place = Place.find(params[:place_id])
    @line = Line.new
    @line.start_date = DateTime.now
    @line.end_date = @line.start_date
    @line.active = true
    @line.place = @place
    @line.user = current_user
    @line.save!
    redirect_to place_line_path(@place, @line)
  end

  def update
    @place = Place.find(params[:place_id])
    @line = Line.find(params[:id])
    @line.end_date = DateTime.now
    @line.active = false
    @line.save!
    PlaceChannel.broadcast_to(
      @place.google_place_id,
      render_to_string(partial: "lines/info", locals: { place: @place, line: @line })
    )
    redirect_to place_line_path(@place, @line)
  end

  def show
    @place = Place.find(params[:place_id])
    @line = Line.find(params[:id])
  end

  def refresh
    @line = Line.find(params[:id])
    date = @line.start_date
    timer = Time.zone.local(date.year, date.month, date.day, 0, 0, 0)
    elapsed = Time.zone.now - date
    timer += elapsed
    timer_serialized = timer.to_s.split(" ")[1]
    render json: { results: timer_serialized }
  end
end
