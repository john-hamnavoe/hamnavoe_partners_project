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

ActiveRecord::Schema.define(version: 2021_03_16_162624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "issue_no"
    t.string "external_no"
    t.string "target_build"
    t.string "author"
    t.string "issue_type"
    t.string "title"
    t.string "issue_status"
    t.string "assigned_to"
    t.string "issue_priority"
    t.string "application_name"
    t.string "notes"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "with_customer", default: true
    t.bigint "ticket_id"
    t.text "current_status"
    t.text "next_steps"
    t.string "tags"
    t.index ["issue_no", "project_id"], name: "index_issues_on_issue_no_and_project_id", unique: true
    t.index ["project_id"], name: "index_issues_on_project_id"
    t.index ["ticket_id"], name: "index_issues_on_ticket_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "ticket_no"
    t.string "title"
    t.string "ticket_status"
    t.string "ticket_type"
    t.string "ticket_priority"
    t.string "ticket_reason"
    t.string "target_branch"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_tickets_on_project_id"
    t.index ["ticket_no", "project_id"], name: "index_tickets_on_ticket_no_and_project_id", unique: true
  end

  create_table "time_entries", force: :cascade do |t|
    t.bigint "timesheet_id", null: false
    t.string "description"
    t.float "hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["timesheet_id"], name: "index_time_entries_on_timesheet_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.date "start"
    t.date "end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_timesheets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "issues", "projects"
  add_foreign_key "issues", "tickets"
  add_foreign_key "tickets", "projects"
  add_foreign_key "time_entries", "timesheets"
  add_foreign_key "timesheets", "users"
end
