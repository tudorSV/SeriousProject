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

ActiveRecord::Schema.define(version: 2019_04_04_135622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "short_address"
    t.string "full_address"
    t.string "city"
    t.string "zipcode"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.date "date"
    t.integer "item_number"
    t.string "status", default: "booked"
    t.bigint "user_id"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_appointments_on_shop_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "role"
    t.bigint "user_id"
    t.bigint "company_id"
    t.bigint "shop_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_employees_on_address_id"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["shop_id"], name: "index_employees_on_shop_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "shop_slots", force: :cascade do |t|
    t.integer "day"
    t.integer "max_appointments"
    t.time "open_hour"
    t.time "close_hour"
    t.boolean "closed", default: false
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_shop_slots_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "active", default: true
    t.bigint "company_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_shops_on_address_id"
    t.index ["company_id"], name: "index_shops_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.boolean "admin", default: true
    t.string "email"
    t.string "phone_number"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_users_on_address_id"
  end

end
