class CreateUfoHotspots < ActiveRecord::Migration[5.2]
  def change
    create_table :ufo_hotspots do |t|
      t.string :name
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
