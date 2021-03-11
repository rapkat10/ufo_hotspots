require 'csv'
require 'json'

namespace :ufo_sightings do
  desc 'Populate UFO Hotspots'
  
  task load_csv_file: :environment do
    if ENV['filename'].nil?
      puts "Please enter a filename: ex. 'filename=ufo_sightings'".red
      return
    end
    file = File.join(Rails.root, 'lib', 'assets', "#{ENV['filename']}.csv")
    created = 0
    skipped = 0
    CSV.open(file).each_with_index do |row, idx|
      if idx > 0
        location = row[5].split('(')
        latitude, longitude = location[1].split(':')[0], location[1].split(':')[1]
        attributes = {
          sighting_date: row[0],
          shape: row[1],
          seconds: row[2],
          minutes: row[3],
          comment: row[4],
          location: location[0],
          latitude: latitude,
          longitude: ''
        }
        if longitude
          attributes[:longitude] = longitude[0..(longitude.size - 2)]
          ufo_sighting = UfoSighting.where(latitude: attributes[:latitude], longitude: attributes[:longitude])
          if !ufo_sighting.present?
            created += 1
            ufo_sighting = UfoSighting.create(attributes)
          else
            skipped += 1
          end
        end
        puts "Example record: #{UfoSighting.last.attributes}".green if idx == 1
      end
	  end
    puts "created: #{created}".green
    puts "skipped: #{skipped}".yellow
  end

  task within_range: :environment do
    rad_per_deg = Math::PI / 180
    radius_km = 6371 # Earth radius in kilometers
    ufo_sightings_within_range = {}
    ufo_hotspots = UfoHotspot.all
    ufo_hotspots.each { |ufo_hotspot| ufo_sightings_within_range[ufo_hotspot.name] = [] }

    ufo_hotspots.each do |ufo_hotspot|
      UfoSighting.all.each do |ufo_sighting|
        lat1, lat2 = ufo_hotspot.latitude.to_i, ufo_sighting.latitude.to_i # east is +, west is -
        lon1, lon2 = ufo_hotspot.longitude.to_i, ufo_sighting.longitude.to_i
        lat1_rad, lat2_rad = lat1 * rad_per_deg, lat2 * rad_per_deg
        lon1_rad, lon2_rad = lon1 * rad_per_deg, lon2 * rad_per_deg
        a = Math.sin((lat2_rad - lat1_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2) ** 2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))
        distance_in_kilometers = radius_km * c
        ufo_sightings_within_range[ufo_hotspot.name].push(ufo_sighting.attributes) if distance_in_kilometers < 1500
      end
    end
    
    File.open("ufo_sightings_within_range/ufo_sightings_within_range.json","w") do |f|
      f.write(JSON.pretty_generate(ufo_sightings_within_range))
    end
  end
end