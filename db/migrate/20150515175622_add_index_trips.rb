class AddIndexTrips < ActiveRecord::Migration
  def up
    add_index :trips, [:name], unique: true
    add_index :trips, [:trip_date], unique: true
  end
end
