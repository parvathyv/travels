class CreateTrips < ActiveRecord::Migration

  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :description, null: false
      t.date :trip_date, null: false
      t.timestamps
    end
  end

end
