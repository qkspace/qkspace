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

ActiveRecord::Schema.define(version: 2019_10_19_145214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "ltree"
  enable_extension "plpgsql"

  create_table "pages", id: :serial, force: :cascade do |t|
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
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "user_id"], name: "index_project_collaborations_on_project_id_and_user_id", unique: true
    t.index ["project_id"], name: "index_project_collaborations_on_project_id"
    t.index ["user_id"], name: "index_project_collaborations_on_user_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
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
    t.boolean "discussions_enabled", default: false
    t.boolean "comments_enabled", default: false
    t.boolean "allow_unregistered_comments", default: false
    t.index ["domain"], name: "index_projects_on_domain", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id"
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

  create_table "threaded_items", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "page_id"
    t.text "source"
    t.text "html"
    t.boolean "deleted", default: false
    t.ltree "path"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_threaded_items_on_page_id"
    t.index ["path"], name: "index_threaded_items_on_path", using: :gist
    t.index ["user_id"], name: "index_threaded_items_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "pages", "projects"
  add_foreign_key "project_collaborations", "projects"
  add_foreign_key "project_collaborations", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "threaded_items", "pages"
  add_foreign_key "threaded_items", "users"
end
