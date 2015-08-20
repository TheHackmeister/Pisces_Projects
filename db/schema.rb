# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150820210213) do

  create_table "cdb_batch_projects", force: :cascade do |t|
    t.integer  "cdb_batch_id", limit: 4
    t.integer  "project_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cdb_batch_projects", ["cdb_batch_id"], name: "index_cdb_batch_projects_on_cdb_batch_id", using: :btree
  add_index "cdb_batch_projects", ["project_id"], name: "index_cdb_batch_projects_on_project_id", using: :btree

  create_table "communication_statuses", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "val",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communication_types", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "val",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communications", force: :cascade do |t|
    t.string   "summary",                 limit: 255
    t.text     "notes",                   limit: 65535
    t.integer  "communication_status_id", limit: 4
    t.integer  "communication_type_id",   limit: 4
    t.integer  "project_id",              limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id",              limit: 4
    t.date     "comm_date"
  end

  add_index "communications", ["communication_status_id"], name: "index_communications_on_communication_status_id", using: :btree
  add_index "communications", ["communication_type_id"], name: "index_communications_on_communication_type_id", using: :btree
  add_index "communications", ["contact_id"], name: "index_communications_on_contact_id", using: :btree
  add_index "communications", ["project_id"], name: "index_communications_on_project_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "contact_name", limit: 255
    t.string   "phone",        limit: 255
    t.string   "email",        limit: 255
    t.text     "address",      limit: 65535
    t.integer  "project_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "customer_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priorities", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "val",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_links", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "sort",       limit: 4
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",      limit: 255
  end

  add_index "project_links", ["project_id"], name: "index_project_links_on_project_id", using: :btree

  create_table "project_types", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "val",        limit: 4
    t.integer  "sort",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.date     "started"
    t.string   "goal",             limit: 255
    t.integer  "customer_id",      limit: 4
    t.integer  "priority_id",      limit: 4
    t.integer  "status_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",            limit: 255
    t.text     "notes",            limit: 65535
    t.text     "customer_notes",   limit: 65535
    t.text     "stumbling_blocks", limit: 65535
    t.date     "soft_deadline"
    t.integer  "project_type_id",  limit: 4
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  add_index "projects", ["priority_id"], name: "index_projects_on_priority_id", using: :btree
  add_index "projects", ["status_id"], name: "index_projects_on_status_id", using: :btree

  create_table "role_assignments", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "role_assignments", ["role_id"], name: "index_role_assignments_on_role_id", using: :btree
  add_index "role_assignments", ["user_id"], name: "index_role_assignments_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "val",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samples", force: :cascade do |t|
    t.integer  "customer_id",   limit: 4
    t.integer  "pisces_number", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "samples", ["customer_id"], name: "index_samples_on_customer_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "val",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "step_statuses", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "val",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", force: :cascade do |t|
    t.string   "action",         limit: 255
    t.text     "note",           limit: 65535
    t.integer  "val",            limit: 4
    t.integer  "step_status_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id",     limit: 4
    t.date     "due"
  end

  add_index "steps", ["project_id"], name: "index_steps_on_project_id", using: :btree
  add_index "steps", ["step_status_id"], name: "index_steps_on_step_status_id", using: :btree

  create_table "test_thing_twos", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "project_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "test_thing_twos", ["project_id"], name: "index_test_thing_twos_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "first",                  limit: 255
    t.string   "last",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid",                    limit: 255, default: "", null: false
    t.string   "token",                  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "cdb_batch_projects", "projects"
  add_foreign_key "test_thing_twos", "projects"
end
