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

ActiveRecord::Schema.define(version: 20130715181020) do

  create_table "call_jobs", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "external_job_id"
    t.string   "call_sid"
    t.integer  "contact_method"
    t.string   "status_callback"
    t.string   "body"
  end

  add_index "call_jobs", ["call_sid"], name: "index_call_jobs_on_call_sid", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "microposts", force: true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.string   "phone"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "company_name"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "ratings", force: true do |t|
    t.string   "description"
    t.integer  "provider_id"
    t.float    "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_id"
  end

  create_table "recommendations", force: true do |t|
    t.integer  "user_id"
    t.integer  "provider_id"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "neighbor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["user_id", "neighbor_id"], name: "index_relationships_on_user_id_and_neighbor_id", unique: true, using: :btree

  create_table "request_histories", force: true do |t|
    t.string   "status"
    t.integer  "request_id"
    t.integer  "request_provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_providers", force: true do |t|
    t.integer  "request_id"
    t.integer  "provider_id"
    t.integer  "call_order"
    t.boolean  "contacted",   default: false
    t.boolean  "accepted",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "status"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.integer  "user_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "category_id"
    t.integer  "last_contacted_provider_id"
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "scores", force: true do |t|
    t.float    "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_id"
    t.integer  "category_id"
  end

  add_index "scores", ["category_id", "provider_id"], name: "index_scores_on_category_id_and_provider_id", unique: true, using: :btree

  create_table "twilio_contacts", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "call_order"
    t.integer  "call_job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "contacted",           default: false
    t.boolean  "accepted",            default: false
    t.string   "call_sid"
    t.string   "category"
    t.integer  "external_contact_id"
  end

  add_index "twilio_contacts", ["call_sid"], name: "index_twilio_contacts_on_call_sid", unique: true, using: :btree

  create_table "twilio_histories", force: true do |t|
    t.string   "call_sid"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_sid"
    t.string   "to_zip"
    t.string   "from_state"
    t.string   "called"
    t.string   "from_country"
    t.string   "caller_country"
    t.string   "called_zip"
    t.string   "direction"
    t.string   "from_city"
    t.string   "called_country"
    t.string   "duration"
    t.string   "caller_state"
    t.string   "called_state"
    t.string   "from"
    t.string   "caller_zip"
    t.string   "from_zip"
    t.string   "call_status"
    t.string   "to_city"
    t.string   "to_state"
    t.string   "to"
    t.string   "call_duration"
    t.string   "to_country"
    t.string   "caller_city"
    t.string   "api_version"
    t.string   "caller"
    t.string   "called_city"
    t.string   "digits"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
