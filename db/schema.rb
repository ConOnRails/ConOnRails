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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111023030220) do

  create_table "entries", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "event_id"
  end

  create_table "event_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
  end

  create_table "events", :force => true do |t|
    t.integer  "event_type_id"
    t.integer  "event_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sticky_flag",       :default => false
    t.boolean  "confidential_flag", :default => false
    t.boolean  "is_active",         :default => true
    t.boolean  "comment"
    t.boolean  "flagged"
    t.boolean  "post_con"
    t.boolean  "quote"
    t.boolean  "sticky"
    t.boolean  "emergency"
    t.boolean  "medical"
    t.boolean  "hidden"
    t.boolean  "secure"
    t.boolean  "consuite"
    t.boolean  "hotel"
    t.boolean  "parties"
    t.boolean  "volunteers"
    t.boolean  "dealers"
    t.boolean  "dock"
    t.boolean  "merchandise"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "realname"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
