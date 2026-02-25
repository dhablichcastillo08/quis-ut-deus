# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_02_25_211345) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_readings", force: :cascade do |t|
    t.date "date"
    t.string "title"
    t.text "first_reading"
    t.text "psalm"
    t.text "second_reading"
    t.text "gospel"
    t.string "saint_of_the_day"
    t.string "feast_day"
    t.string "liturgical_color"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "journal_entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "daily_reading_id", null: false
    t.date "date"
    t.text "content"
    t.string "mood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_reading_id"], name: "index_journal_entries_on_daily_reading_id"
    t.index ["user_id"], name: "index_journal_entries_on_user_id"
  end

  create_table "prayer_habits", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "description"
    t.string "frequency"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_prayer_habits_on_user_id"
  end

  create_table "prayer_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "prayer_habit_id", null: false
    t.datetime "completed_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prayer_habit_id"], name: "index_prayer_logs_on_prayer_habit_id"
    t.index ["user_id"], name: "index_prayer_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "journal_entries", "daily_readings"
  add_foreign_key "journal_entries", "users"
  add_foreign_key "prayer_habits", "users"
  add_foreign_key "prayer_logs", "prayer_habits"
  add_foreign_key "prayer_logs", "users"
end
