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

ActiveRecord::Schema[7.1].define(version: 2024_11_25_071520) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hosts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "voice"
    t.string "nationality"
    t.integer "age"
    t.string "location"
    t.string "work"
    t.string "family"
    t.string "likes"
    t.string "dislikes"
    t.string "hobbies"
    t.string "stories", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "podcasts", force: :cascade do |t|
    t.bigint "user_language_id", null: false
    t.bigint "host_id", null: false
    t.text "transcript"
    t.string "summary"
    t.string "ai_summary"
    t.string "native_language"
    t.string "level"
    t.string "learning_style"
    t.string "user_prompt"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_podcasts_on_host_id"
    t.index ["user_language_id"], name: "index_podcasts_on_user_language_id"
  end

  create_table "user_languages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "language"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_languages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "selected_user_language_id"
    t.string "first_name"
    t.string "last_name"
    t.string "native_language"
    t.string "learning_style"
    t.string "interests"
    t.string "suggested_topics", array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["selected_user_language_id"], name: "index_users_on_selected_user_language_id"
  end

  add_foreign_key "podcasts", "hosts"
  add_foreign_key "podcasts", "user_languages"
  add_foreign_key "user_languages", "users"
  add_foreign_key "users", "user_languages", column: "selected_user_language_id"
end
