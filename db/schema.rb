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

ActiveRecord::Schema.define(version: 2019_04_25_223834) do

  create_table "infection_reports", force: :cascade do |t|
    t.integer "survivor_reported_id"
    t.integer "survivor_reporter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survivor_reported_id"], name: "index_infection_reports_on_survivor_reported_id"
    t.index ["survivor_reporter_id"], name: "index_infection_reports_on_survivor_reporter_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "water"
    t.integer "food"
    t.integer "medication"
    t.integer "ammo"
    t.integer "survivor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survivor_id"], name: "index_inventories_on_survivor_id"
  end

  create_table "survivors", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "gender"
    t.string "latitude"
    t.string "longitude"
    t.boolean "infected", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
