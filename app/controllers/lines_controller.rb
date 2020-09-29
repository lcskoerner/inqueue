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
    @colors = { white: "white", green: "#D8FFD8", orange: "#FCC97D", red: "#F1A298" }
    @line.end_date = DateTime.now
    @line.active = false
    @line.save!
    @place.last_line = ((@line.end_date - @line.start_date) / 60).to_i
    @place.save!

    PlaceChannel.broadcast_to(
      @place.google_place_id,
      [@colors[helpers.set_color(@place.last_line).to_sym], render_to_string(partial: "lines/info", locals: { place: @place, line: @line })]
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
