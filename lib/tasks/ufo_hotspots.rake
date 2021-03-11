namespace :ufo_hotspots do

  desc 'Populate UFO Hotspots'
  
  task populate: :environment do
    ufo_hotspots = {
      'The White House': {latitude: '38.897663', longitude: '-77.036575'},
      "World’s Tallest Thermometer": {latitude: '35.26644', longitude: '-116.07275'},
      'Area 51': {latitude: '37.233333', longitude: '-115.808333'},
      "Disney World’s Magic Kingdom": {latitude: '28.404010', longitude: '-81.576900'},
      "Pop's Soda Bottle": {latitude: '35.658340', longitude: '-97.335490'}
    }
    UfoHotspot.destroy_all
    ufo_hotspots.each { |k, v| UfoHotspot.create(name: k, latitude: v[:latitude], longitude: v[:longitude]) }
    UfoHotspot.all.each { |ufo_hotspot| puts "#{ufo_hotspot.name}: #{ufo_hotspot.attributes}".yellow }
  end

end