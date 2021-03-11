class Api::V01::UfoHotspotsController < Api::V01::BaseController

  def index #/api/v01/ufo_hotspots
    render json: { success: true, response: UfoHotspot.all }
  end

end