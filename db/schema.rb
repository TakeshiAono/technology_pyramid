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

ActiveRecord::Schema.define(version: 2022_09_14_015121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "favorite_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite_id"], name: "index_favorites_on_favorite_id"
    t.index ["user_id", "favorite_id"], name: "index_favorites_on_user_id_and_favorite_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "hierarckies", force: :cascade do |t|
    t.bigint "technology_id", null: false
    t.bigint "lower_technology_id"
    t.bigint "access_counter"
    t.bigint "good_counter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technology_id"], name: "index_hierarckies_on_technology_id"
  end

  create_table "link_goods", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["link_id"], name: "index_link_goods_on_link_id"
    t.index ["user_id"], name: "index_link_goods_on_user_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "good_counter", default: 0
    t.bigint "technology_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technology_id"], name: "index_links_on_technology_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string "name"
    t.boolean "public_flag"
    t.bigint "work_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "basic_flag", default: true
    t.index ["work_id"], name: "index_technologies_on_work_id"
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
    t.boolean "active_flag", default: true
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "users", column: "favorite_id"
  add_foreign_key "hierarckies", "technologies"
  add_foreign_key "hierarckies", "technologies", column: "lower_technology_id"
  add_foreign_key "link_goods", "links"
  add_foreign_key "link_goods", "users"
  add_foreign_key "links", "technologies"
  add_foreign_key "technologies", "works"
  add_foreign_key "works", "users"
end
