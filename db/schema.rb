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

ActiveRecord::Schema.define(version: 20140701203907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shippers", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracker_logs", force: true do |t|
    t.string   "message"
    t.string   "code"
    t.json     "snapshot"
    t.integer  "tracker_id"
    t.integer  "status_id"
    t.integer  "shipper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracker_logs", ["shipper_id"], name: "index_tracker_logs_on_shipper_id", using: :btree
  add_index "tracker_logs", ["status_id"], name: "index_tracker_logs_on_status_id", using: :btree
  add_index "tracker_logs", ["tracker_id"], name: "index_tracker_logs_on_tracker_id", using: :btree

  create_table "trackers", force: true do |t|
    t.string   "code"
    t.string   "login_id"
    t.string   "login_pass"
    t.string   "login_token"
    t.string   "url"
    t.integer  "shipper_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trackers", ["shipper_id"], name: "index_trackers_on_shipper_id", using: :btree
  add_index "trackers", ["status_id"], name: "index_trackers_on_status_id", using: :btree

end
