class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :tripdetails_id, null: false
      t.timestamps
    end
  end
end
