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

ActiveRecord::Schema.define(version: 20141027204048) do

  create_table "communication_statuses", force: true do |t|
    t.string   "text"
    t.integer  "val"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communication_types", force: true do |t|
    t.string   "text"
    t.integer  "val"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communications", force: true do |t|
    t.string   "summary"
    t.text     "notes"
    t.integer  "communication_status_id"
    t.integer  "communication_type_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
  end

  add_index "communications", ["communication_status_id"], name: "index_communications_on_communication_status_id", using: :btree
  add_index "communications", ["communication_type_id"], name: "index_communications_on_communication_type_id", using: :btree
  add_index "communications", ["contact_id"], name: "index_communications_on_contact_id", using: :btree
  add_index "communications", ["project_id"], name: "index_communications_on_project_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "contact_name"
    t.string   "phone"
    t.string   "email"
    t.text     "address"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "customer_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priorities", force: true do |t|
    t.string   "text"
    t.integer  "val"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_links", force: true do |t|
    t.integer  "Project_id"
    t.integer  "sort"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes"
  end

  add_index "project_links", ["Project_id"], name: "index_project_links_on_Project_id", using: :btree

  create_table "projects", force: true do |t|
    t.date     "started"
    t.string   "goal"
    t.integer  "customer_id"
    t.integer  "priority_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "notes"
    t.text     "customer_notes"
    t.text     "stumbling_blocks"
    t.date     "soft_deadline"
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  add_index "projects", ["priority_id"], name: "index_projects_on_priority_id", using: :btree
  add_index "projects", ["status_id"], name: "index_projects_on_status_id", using: :btree

  create_table "statuses", force: true do |t|
    t.string   "text"
    t.integer  "val"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "step_statuses", force: true do |t|
    t.string   "text"
    t.integer  "val"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", force: true do |t|
    t.string   "action"
    t.text     "note"
    t.integer  "val"
    t.integer  "step_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.date     "due"
  end

  add_index "steps", ["project_id"], name: "index_steps_on_project_id", using: :btree
  add_index "steps", ["step_status_id"], name: "index_steps_on_step_status_id", using: :btree

end
