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

ActiveRecord::Schema.define(version: 20131029202051) do

  create_table "appraisal_fees", force: true do |t|
    t.integer  "duration_from"
    t.integer  "duration_to"
    t.float    "percentual"
    t.float    "fixed_min"
    t.float    "fixed_max"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loan_id"
  end

  create_table "banks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insurance_fees", force: true do |t|
    t.integer  "duration_from"
    t.integer  "duration_to"
    t.float    "percentual"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loan_id"
  end

  create_table "interest_rates", force: true do |t|
    t.boolean  "fixed"
    t.integer  "duration_from"
    t.integer  "duration_to"
    t.boolean  "bank_customer"
    t.boolean  "insured"
    t.float    "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loan_id"
  end

  create_table "loan_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bank_id"
    t.integer  "loan_type_id"
    t.string   "reference_rate"
  end

  create_table "reference_rates", force: true do |t|
    t.string   "name"
    t.float    "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  add_index "reference_rates", ["name", "date"], name: "index_reference_rates_on_name_and_date", unique: true

  create_table "tmp_loans", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bank_id"
    t.integer  "loan_type_id"
    t.integer  "reference_rate"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
