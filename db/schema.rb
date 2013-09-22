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

ActiveRecord::Schema.define(version: 20130922110140) do

  create_table "copters", force: true do |t|
    t.integer  "hospital_id"
    t.string   "name"
    t.string   "category"
    t.float    "last_latitude"
    t.float    "last_longitude"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "copters", ["hospital_id"], name: "index_copters_on_hospital_id"

  create_table "destinations", force: true do |t|
    t.integer  "hospital_id"
    t.string   "name"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "destinations", ["hospital_id"], name: "index_destinations_on_hospital_id"

  create_table "histories", force: true do |t|
    t.integer  "copter_id"
    t.integer  "hospital_id"
    t.integer  "destination_id"
    t.string   "time_left"
    t.string   "time_delivered"
    t.string   "time_returned"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["copter_id"], name: "index_histories_on_copter_id"
  add_index "histories", ["destination_id"], name: "index_histories_on_destination_id"
  add_index "histories", ["hospital_id"], name: "index_histories_on_hospital_id"

  create_table "hospitals", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medicines", force: true do |t|
    t.integer  "hospital_id"
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.boolean  "restricted"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medicines", ["hospital_id"], name: "index_medicines_on_hospital_id"

  create_table "requested_medicines", force: true do |t|
    t.integer  "request_id"
    t.integer  "medicine_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requested_medicines", ["medicine_id"], name: "index_requested_medicines_on_medicine_id"
  add_index "requested_medicines", ["request_id"], name: "index_requested_medicines_on_request_id"

  create_table "requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "hospital_id"
    t.integer  "destination_id"
    t.string   "time_requested"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["destination_id"], name: "index_requests_on_destination_id"
  add_index "requests", ["hospital_id"], name: "index_requests_on_hospital_id"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "users", force: true do |t|
    t.integer  "hospital_id"
    t.string   "name"
    t.string   "phone_number"
    t.integer  "priveledge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["hospital_id"], name: "index_users_on_hospital_id"

end
