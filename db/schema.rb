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

ActiveRecord::Schema.define(version: 2020_07_10_202329) do

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "position", null: false
    t.text "source"
    t.text "html"
    t.index ["position"], name: "index_pages_on_position"
    t.index ["project_id"], name: "index_pages_on_project_id"
  end

  create_table "project_collaborations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "user_id"], name: "index_project_collaborations_on_project_id_and_user_id", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "user_id"
    t.string "google_analytics_tracker_id"
    t.string "domain"
    t.boolean "private", default: false
    t.boolean "secret_enabled", default: false, null: false
    t.string "secret_token"
    t.string "yandex_metrika_tracker_id"
    t.string "google_remarketing_tracker_id"
    t.index ["domain"], name: "index_projects_on_domain", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "timeout_at", null: false
    t.datetime "expires_at", null: false
    t.text "user_agent"
    t.string "remote_addr"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "type"
    t.integer "project_id"
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
