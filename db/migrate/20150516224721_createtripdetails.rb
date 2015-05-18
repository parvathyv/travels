class Createtripdetails < ActiveRecord::Migration
  def change
    create_table :tripdetails do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :description, null: false
      t.date :trip_id, null: false
      t.timestamps
    end
  end
end
