class Api::V01::UfoSightingsController < Api::V01::BaseController

  def index
    ufo_sightings_within_range
  end

  def create #/api/v01/ufo_sightings
    ufo_sighting = UfoSighting.new(ufo_sighting_params)
    if ufo_sighting.save
      render json: { success: true, response: ufo_sighting }
    else
      render json: { success: false }
    end
  end

  private

  def ufo_sighting_params
    params.permit(
      :sighting_date,
      :shape,
      :duration,
      :comment,
      :city,
      :state,
      :latitude,
      :longitude,
    )
  end

  def ufo_sightings_within_range
    @ufo_sightings_within_range = {}
    ufo_hotspots = UfoHotspot.all
    ufo_hotspots.each { |ufo_hotspot| @ufo_sightings_within_range[ufo_hotspot.name] = [] }
    ufo_hotspots.each { |ufo_hotspot| check_ufo_sightings(ufo_hotspot) }
    render json: { success: true, response: @ufo_sightings_within_range }
  end

  def check_ufo_sightings(ufo_hotspot)
    number_of_sightings_per_page = 50
    page = params[:page] ? params[:page].to_i : 1
    UfoSighting.all.offset(page * number_of_sightings_per_page).limit(number_of_sightings_per_page).each do |ufo_sighting|
      @ufo_sightings_within_range[ufo_hotspot.name].push(ufo_sighting.attributes) if calculate_distance_between_2_coordinates(ufo_hotspot, ufo_sighting) < 1500
    end
  end

  def calculate_distance_between_2_coordinates(ufo_hotspot, ufo_sighting)
    rad_per_deg = Math::PI / 180
    lat1_rad, lat2_rad = ufo_hotspot.latitude.to_i * rad_per_deg, ufo_sighting.latitude.to_i * rad_per_deg
    lon1_rad, lon2_rad = ufo_hotspot.longitude.to_i * rad_per_deg, ufo_sighting.longitude.to_i * rad_per_deg
    a = Math.sin((lat2_rad - lat1_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2) ** 2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))
    6371 * c # 6371 is Earth's radius in KM
  end
end