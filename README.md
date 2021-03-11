# ufo_hotspots


## Initial Setup

  - run `rake ufo_hotspots:populate` to populate the 5 UFO sensitive hotspots in the US.

## Loading UFO Sightings via CSV File in the Command Line
  - run `rake ufo_sightings:load_csv_file filename=ufo_sightings` to populate ufo sightings using CSV File.
  - add your CSV File under lib/assets, and when you run the above command enter your CSV filname.

## Retrieve JSON File of hotspots and ufo sightings within 1500 kilometers of the hotspots

  - run `rake ufo_sightings:within_range`