class CreateUfoSightings < ActiveRecord::Migration[5.2]
  def change
    create_table :ufo_sightings do |t|
      t.string :sighting_date
      t.string :shape
      t.string :seconds
      t.string :minutes
      t.string :comment
      t.integer :duration
      t.string :city
      t.string :state
      t.string :location
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
