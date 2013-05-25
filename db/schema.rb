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

ActiveRecord::Schema.define(:version => 20130525174214) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "department"
    t.string   "cell_phone"
    t.string   "hotel"
    t.integer  "hotel_room"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "can_text",   :default => false
    t.string   "position"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "volunteer_id"
    t.integer  "radio_group_id"
    t.integer  "radio_allotment"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "duty_board_assignments", :force => true do |t|
    t.integer  "duty_board_slot_id"
    t.string   "notes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "name"
    t.string   "string"
  end

  create_table "duty_board_groups", :force => true do |t|
    t.string   "name"
    t.integer  "row"
    t.integer  "column"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "duty_board_slots", :force => true do |t|
    t.string   "name"
    t.integer  "duty_board_group_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "entries", :force => true do |t|
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "rolename"
  end

  create_table "event_flag_histories", :force => true do |t|
    t.integer  "event_id"
    t.boolean  "is_active",   :default => false
    t.boolean  "comment",     :default => false
    t.boolean  "flagged",     :default => false
    t.boolean  "post_con",    :default => false
    t.boolean  "quote",       :default => false
    t.boolean  "sticky",      :default => false
    t.boolean  "emergency",   :default => false
    t.boolean  "medical",     :default => false
    t.boolean  "hidden",      :default => false
    t.boolean  "secure",      :default => false
    t.boolean  "consuite",    :default => false
    t.boolean  "hotel",       :default => false
    t.boolean  "parties",     :default => false
    t.boolean  "volunteers",  :default => false
    t.boolean  "dealers",     :default => false
    t.boolean  "dock",        :default => false
    t.boolean  "merchandise", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
    t.datetime "orig_time"
    t.string   "rolename"
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "is_active",       :default => true
    t.boolean  "comment",         :default => false
    t.boolean  "flagged",         :default => false
    t.boolean  "post_con",        :default => false
    t.boolean  "quote",           :default => false
    t.boolean  "sticky",          :default => false
    t.boolean  "emergency",       :default => false
    t.boolean  "medical",         :default => false
    t.boolean  "hidden",          :default => false
    t.boolean  "secure",          :default => false
    t.boolean  "consuite"
    t.boolean  "hotel"
    t.boolean  "parties"
    t.boolean  "volunteers"
    t.boolean  "dealers"
    t.boolean  "dock"
    t.boolean  "merchandise"
    t.string   "merged_from_ids"
    t.boolean  "merged"
  end

  create_table "login_logs", :force => true do |t|
    t.string   "user_name"
    t.string   "role_name"
    t.string   "comment"
    t.string   "ip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lost_and_found_items", :force => true do |t|
    t.string   "category"
    t.string   "description"
    t.text     "details"
    t.string   "where_last_seen"
    t.string   "where_found"
    t.string   "owner_name"
    t.text     "owner_contact"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "found",            :default => false
    t.boolean  "returned",         :default => false
    t.boolean  "reported_missing", :default => false
    t.integer  "user_id"
    t.string   "rolename"
  end

  create_table "messages", :force => true do |t|
    t.string   "for"
    t.string   "phone_number"
    t.string   "room_number"
    t.string   "hotel"
    t.integer  "user_id"
    t.text     "message"
    t.boolean  "is_active",    :default => true
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "radio_assignment_audits", :force => true do |t|
    t.integer  "radio_id"
    t.integer  "volunteer_id"
    t.string   "state"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.integer  "department_id"
  end

  create_table "radio_assignments", :force => true do |t|
    t.integer  "radio_id"
    t.integer  "volunteer_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "department_id"
  end

  create_table "radio_groups", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "radios", :force => true do |t|
    t.string   "number"
    t.string   "notes"
    t.integer  "radio_group_id"
    t.string   "image_filename"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "state",          :default => "in"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "write_entries"
    t.boolean  "read_hidden_entries"
    t.boolean  "add_lost_and_found"
    t.boolean  "modify_lost_and_found"
    t.boolean  "admin_radios"
    t.boolean  "assign_radios"
    t.boolean  "admin_users"
    t.boolean  "admin_schedule"
    t.boolean  "assign_shifts"
    t.boolean  "assign_duty_board_slots"
    t.boolean  "admin_duty_board"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "make_hidden_entries",     :default => false
    t.boolean  "rw_secure",               :default => false
    t.boolean  "read_audits",             :default => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], :name => "index_roles_users_on_role_id_and_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "realname"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

  create_table "volunteer_trainings", :force => true do |t|
    t.integer  "volunteer_id"
    t.boolean  "radio",          :default => false
    t.boolean  "ops_basics",     :default => false
    t.boolean  "first_contact",  :default => false
    t.boolean  "communications", :default => false
    t.boolean  "dispatch",       :default => false
    t.boolean  "wandering_host", :default => false
    t.boolean  "xo",             :default => false
    t.boolean  "ops_subhead",    :default => false
    t.boolean  "ops_head",       :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "volunteers", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "city"
    t.string   "state"
    t.string   "postal"
    t.string   "country"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "other_phone"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

end
