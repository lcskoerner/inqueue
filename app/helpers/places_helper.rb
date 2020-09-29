module PlacesHelper
  def set_color(time)
    return "white" if time.nil?

    if time >= 30
      return "red"
    elsif time >= 15
      return "orange"
    elsif time < 15
      return "green"
    end
  end


end
