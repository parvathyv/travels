# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150518190324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "photos", force: :cascade do |t|
    t.string   "photo_name",    null: false
    t.text     "description",   null: false
    t.integer  "tripdetail_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tripdetails", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "address",     null: false
    t.float    "latitude",    null: false
    t.float    "longitude",   null: false
    t.text     "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "address",     null: false
    t.float    "latitude",    null: false
    t.float    "longitude",   null: false
    t.text     "description", null: false
    t.date     "trip_date",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["name"], name: "index_trips_on_name", unique: true, using: :btree
  add_index "trips", ["trip_date"], name: "index_trips_on_trip_date", unique: true, using: :btree

end
