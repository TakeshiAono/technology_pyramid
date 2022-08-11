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

ActiveRecord::Schema.define(version: 2022_08_11_051047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "circulations", force: :cascade do |t|
    t.bigint "pyramid_id", null: false
    t.bigint "technology_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pyramid_id"], name: "index_circulations_on_pyramid_id"
    t.index ["technology_id"], name: "index_circulations_on_technology_id"
  end

  create_table "link_access_counters", force: :cascade do |t|
    t.bigint "pyramid_id", null: false
    t.bigint "link_id", null: false
    t.integer "counter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["link_id"], name: "index_link_access_counters_on_link_id"
    t.index ["pyramid_id"], name: "index_link_access_counters_on_pyramid_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "good_counter"
    t.bigint "technology_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technology_id"], name: "index_links_on_technology_id"
  end

  create_table "pyramids", force: :cascade do |t|
    t.string "name"
    t.boolean "public_flag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "work_id", null: false
    t.index ["work_id"], name: "index_pyramids_on_work_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string "name"
    t.boolean "public_flag"
    t.integer "upper_technology"
    t.integer "lower_technology"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "pyramid_id", null: false
    t.index ["pyramid_id"], name: "index_technologies_on_pyramid_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "industry"
    t.string "occupation"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.string "title"
    t.boolean "public_flag"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active_flag"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "circulations", "pyramids"
  add_foreign_key "circulations", "technologies"
  add_foreign_key "link_access_counters", "links"
  add_foreign_key "link_access_counters", "pyramids"
  add_foreign_key "links", "technologies"
  add_foreign_key "pyramids", "works"
  add_foreign_key "technologies", "pyramids"
  add_foreign_key "technologies", "technologies", column: "lower_technology"
  add_foreign_key "technologies", "technologies", column: "upper_technology"
  add_foreign_key "works", "users"
end
