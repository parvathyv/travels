class FixName < ActiveRecord::Migration
  def self.up
    rename_column :photos, :name, :photo_name
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
