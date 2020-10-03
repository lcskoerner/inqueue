# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_03_160546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lines", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.date "date"
    t.bigint "place_id", null: false
    t.boolean "active"
    t.bigint "user_id"
    t.index ["place_id"], name: "index_lines_on_place_id"
    t.index ["user_id"], name: "index_lines_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.text "address"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.integer "rating"
    t.string "google_place_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "last_line"
    t.string "vicinity"
    t.string "phone_number"
    t.string "place_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "lines", "places"
  add_foreign_key "lines", "users"
end
