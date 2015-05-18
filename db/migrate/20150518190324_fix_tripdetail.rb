class FixTripdetail < ActiveRecord::Migration
 def self.up
    rename_column :photos, :tripdetails_id, :tripdetail_id
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
