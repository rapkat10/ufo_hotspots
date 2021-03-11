# ufo_hotspots

## Initial Setup
  - run `rake ufo_hotspots:populate` to populate the 5 UFO sensitive hotspots in the US.

## Loading UFO Sightings via CSV File in the Command Line
  - run `rake ufo_sightings:load_csv_file filename=ufo_sightings` to populate ufo sightings using CSV File.
  - add your CSV File under lib/assets, and when you run the above command enter your CSV filname.

## Retrieve JSON File of hotspots and ufo sightings within 1500 kilometers of the hotspots in the Command Line
  - run `rake ufo_sightings:within_range`
  - The JSON File will be located under `ufo_sightings_within_range` folder.

## Post request to add individual ufo sighting
  - Make a Post request to `http://localhost:5000/api/v01/ufo_sightings` with params in the body.
  - You will get back the ufo_sighting record in json.

## JSON of sightings within 1500 kilometers of the hotspots
  - Make a Get request to `http://localhost:5000/api/v01/ufo_sightings`.
  - You will get back the response in json.

## Technologies used
  - Ruby on Rails
  - Javascript
  - React
  - Html
  - Bootstrap


 ## Database schema
  - 2 Tables
  - `ufo_hotspots`
  - `ufo_sightings`

## challenges
  - Docker

## Next steps to finish the challenge
  - CRUD for both `UfoHotspot` and `UfoSighting`
  - Create front-end Map using any Map Api.

## Feedback on the challenge itself
  - Great Challenge
  - I really enjoyed working on this project.