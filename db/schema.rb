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

ActiveRecord::Schema.define(version: 20140913060312) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "type",                                null: false
    t.string   "name",                   default: "", null: false
    t.string   "telephone",              default: "", null: false
    t.string   "sex",                                 null: false
    t.text     "roles"
    t.integer  "station_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["telephone"], name: "index_admins_on_telephone", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

  create_table "catagories", force: true do |t|
    t.string   "name",       limit: 10, default: "", null: false
    t.integer  "order",                              null: false
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catagories", ["name"], name: "index_catagories_on_name", unique: true, using: :btree
  add_index "catagories", ["order"], name: "index_catagories_on_order", unique: true, using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "faqs", force: true do |t|
    t.string   "question",       null: false
    t.text     "answer",         null: false
    t.integer  "create_user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faqs", ["create_user_id"], name: "index_faqs_on_create_user_id", using: :btree
  add_index "faqs", ["question"], name: "index_faqs_on_question", using: :btree

  create_table "open_cities", force: true do |t|
    t.string   "name",          null: false
    t.string   "province_code", null: false
    t.string   "city_code",     null: false
    t.string   "short_name",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "open_cities", ["city_code"], name: "index_open_cities_on_city_code", unique: true, using: :btree
  add_index "open_cities", ["short_name"], name: "index_open_cities_on_short_name", unique: true, using: :btree

  create_table "orders", force: true do |t|
    t.string   "type",              null: false
    t.string   "order_no",          null: false
    t.integer  "user_id"
    t.integer  "station_id",        null: false
    t.datetime "order_time",        null: false
    t.string   "owner_name",        null: false
    t.string   "car_number_area",   null: false
    t.string   "car_number_detail", null: false
    t.string   "telephone",         null: false
    t.string   "status",            null: false
    t.text     "switch_settings"
    t.integer  "create_admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_no"], name: "index_orders_on_order_no", using: :btree
  add_index "orders", ["station_id"], name: "index_orders_on_station_id", using: :btree
  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pictures", force: true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title",          default: "", null: false
    t.integer  "catagory_id",                 null: false
    t.text     "content",                     null: false
    t.string   "status",                      null: false
    t.integer  "create_user_id",              null: false
    t.integer  "check_user_id"
    t.text     "reject_reason"
    t.integer  "lock_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["catagory_id"], name: "index_posts_on_catagory_id", using: :btree
  add_index "posts", ["create_user_id"], name: "index_posts_on_create_user_id", using: :btree
  add_index "posts", ["status"], name: "index_posts_on_status", using: :btree
  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree

  create_table "sms_services", force: true do |t|
    t.string   "telephone"
    t.string   "template_id"
    t.string   "description"
    t.text     "options"
    t.integer  "response_code"
    t.integer  "api_code"
    t.string   "api_msg"
    t.text     "result"
    t.text     "exception"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sms_services", ["telephone"], name: "index_sms_services_on_telephone", using: :btree

  create_table "stations", force: true do |t|
    t.string   "name",               default: "", null: false
    t.string   "province",                        null: false
    t.string   "city",                            null: false
    t.string   "district",                        null: false
    t.string   "address",            default: "", null: false
    t.string   "telephone",          default: "", null: false
    t.string   "status",                          null: false
    t.integer  "check_user_id"
    t.text     "reject_reason"
    t.integer  "lock_user_id"
    t.text     "recommend"
    t.text     "time_area_settings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.float    "jingdu"
    t.float    "weidu"
  end

  add_index "stations", ["city"], name: "index_stations_on_city", using: :btree
  add_index "stations", ["district"], name: "index_stations_on_district", using: :btree
  add_index "stations", ["name"], name: "index_stations_on_name", unique: true, using: :btree
  add_index "stations", ["province"], name: "index_stations_on_province", using: :btree

  create_table "uaqs", force: true do |t|
    t.integer  "user_id",           null: false
    t.text     "question",          null: false
    t.integer  "answered_admin_id"
    t.datetime "answered_time"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uaqs", ["answered_admin_id"], name: "index_uaqs_on_answered_admin_id", using: :btree
  add_index "uaqs", ["user_id"], name: "index_uaqs_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "telephone"
    t.string   "sex"
    t.string   "login_type"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["telephone"], name: "index_users_on_telephone", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
