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

ActiveRecord::Schema.define(version: 2019_09_18_180029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "type"
    t.string "email"
    t.bigint "schedule_id"
    t.string "document"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["schedule_id"], name: "index_accounts_on_schedule_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "start_hour"
    t.integer "end_hour"
    t.date "date_appointment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available"
    t.bigint "schedule_id"
    t.index ["account_id"], name: "index_appointments_on_account_id"
    t.index ["schedule_id"], name: "index_appointments_on_schedule_id"
  end

  create_table "customer_appointments", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "appointment_id"
    t.string "name_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_customer_appointments_on_account_id"
    t.index ["appointment_id"], name: "index_customer_appointments_on_appointment_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unit_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_enrollments_on_account_id"
    t.index ["unit_id"], name: "index_enrollments_on_unit_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.integer "gender"
    t.text "address"
    t.string "contact"
    t.string "nickname"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "work_document"
    t.bigint "account_id"
    t.integer "plan"
    t.index ["account_id"], name: "index_profiles_on_account_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "date"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unit_id"
    t.integer "start"
    t.integer "finish"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_schedules_on_account_id"
    t.index ["unit_id"], name: "index_schedules_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ex_gym_ref"
    t.integer "cod"
    t.string "open_hour"
    t.string "close_hour"
    t.string "working_days"
    t.string "address"
  end

  add_foreign_key "accounts", "schedules"
  add_foreign_key "appointments", "accounts"
  add_foreign_key "appointments", "schedules"
  add_foreign_key "customer_appointments", "accounts"
  add_foreign_key "customer_appointments", "appointments"
  add_foreign_key "enrollments", "accounts"
  add_foreign_key "enrollments", "units"
  add_foreign_key "profiles", "accounts"
  add_foreign_key "schedules", "accounts"
  add_foreign_key "schedules", "units"
end
