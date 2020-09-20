class LinesController < ApplicationController
  def new
  end

  def start
    @place = Place.find(params[:id])
    @line = Line.new
    @line.start_date = DateTime.now
    @line.active = true
    @line.place = @place
    @line.save!
    html = render_to_string(partial: "lines/controls", locals:  { place: @place, line: @line })
    render json: { results_html: html }
  end

  def create
  end

  def update
    @place = Place.find(params[:place_id])
    @line = Line.find(params[:id])
    @line.end_date = DateTime.now
    @line.active = false
    @line.save!
    flash[:notice] = "Thank you for your participation!"
    redirect_to place_path(@place)
  end

  def show
  end

  def destroy
  end
end
