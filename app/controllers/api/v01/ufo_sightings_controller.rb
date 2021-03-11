class Api::V01::UfoSightingsController < Api::V01::BaseController

  def index
    puts "params: #{params}".yellow
    ufo_sightings_within_range
  end

  def create #/api/v01/ufo_sightings
    ufo_sighting = UfoSighting.new(ufo_sighting_params)
    if ufo_sighting.save
      render json: { success: true, response: response }
    else
      render json: { success: false }
    end
  end

  private

  def ufo_sighting_params
    params.require(
      :ufo_sighting
    ).permit(
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
    rad_per_deg = Math::PI / 180
    radius_km = 6371 # Earth radius in kilometers
    ufo_sightings_within_range = {}
    UfoHotspot.all.each { |ufo_hotspot| ufo_sightings_within_range[ufo_hotspot.name] = [] }

    number_of_sightings_per_page = 50
    page = params[:page] ? params[:page].to_i : 1
    puts "page: #{page}".yellow
    UfoHotspot.all.each do |ufo_hotspot|
      UfoSighting.all.offset(page * number_of_sightings_per_page).limit(number_of_sightings_per_page).each do |ufo_sighting|
        lat1, lat2 = ufo_hotspot.latitude.to_i, ufo_sighting.latitude.to_i
        lon1, lon2 = ufo_hotspot.longitude.to_i, ufo_sighting.longitude.to_i
        lat1_rad, lat2_rad = lat1 * rad_per_deg, lat2 * rad_per_deg
        lon1_rad, lon2_rad = lon1 * rad_per_deg, lon2 * rad_per_deg
        a = Math.sin((lat2_rad - lat1_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2) ** 2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))
        distance_in_kilometers = radius_km * c
        ufo_sightings_within_range[ufo_hotspot.name].push(ufo_sighting.attributes) if distance_in_kilometers < 1500
      end
    end
    render json: { success: true, response: ufo_sightings_within_range }
  end
end