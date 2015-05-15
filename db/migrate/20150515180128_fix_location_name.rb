class FixLocationName < ActiveRecord::Migration
  def self.up
    rename_column :trips, :location, :address
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
