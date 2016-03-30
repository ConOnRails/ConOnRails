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

ActiveRecord::Schema.define(version: 20160330022732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type",  limit: 255
    t.integer  "associated_id"
    t.string   "associated_type", limit: 255
    t.integer  "user_id"
    t.string   "user_type",       limit: 255
    t.string   "username",        limit: 255
    t.string   "action",          limit: 255
    t.text     "audited_changes"
    t.integer  "version",                     default: 0
    t.string   "comment",         limit: 255
    t.string   "remote_address",  limit: 255
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "department", limit: 255
    t.string   "cell_phone", limit: 255
    t.string   "hotel",      limit: 255
    t.integer  "hotel_room"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_text",               default: false
    t.string   "position",   limit: 255
  end

  create_table "conventions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "volunteer_id"
    t.integer  "radio_group_id"
    t.integer  "radio_allotment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duty_board_assignments", force: :cascade do |t|
    t.integer  "duty_board_slot_id"
    t.string   "notes",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",               limit: 255
    t.string   "string",             limit: 255
  end

  create_table "duty_board_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "row"
    t.integer  "column"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duty_board_slots", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "duty_board_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "rolename",    limit: 255
  end

  create_table "event_flag_histories", force: :cascade do |t|
    t.integer  "event_id"
    t.boolean  "is_active",                default: false
    t.boolean  "post_con",                 default: false
    t.boolean  "sticky",                   default: false
    t.boolean  "emergency",                default: false
    t.boolean  "medical",                  default: false
    t.boolean  "hidden",                   default: false
    t.boolean  "secure",                   default: false
    t.boolean  "consuite",                 default: false
    t.boolean  "hotel",                    default: false
    t.boolean  "parties",                  default: false
    t.boolean  "volunteers",               default: false
    t.boolean  "dealers",                  default: false
    t.boolean  "dock",                     default: false
    t.boolean  "merchandise",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "orig_time"
    t.string   "rolename",     limit: 255
    t.boolean  "merged"
    t.boolean  "nerf_herders",             default: false
  end

  create_table "event_sections", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_sections", ["event_id"], name: "index_event_sections_on_event_id", using: :btree
  add_index "event_sections", ["section_id"], name: "index_event_sections_on_section_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                   default: true
    t.boolean  "post_con",                    default: false
    t.boolean  "sticky",                      default: false
    t.boolean  "emergency",                   default: false
    t.boolean  "medical",                     default: false
    t.boolean  "hidden",                      default: false
    t.boolean  "secure",                      default: false
    t.boolean  "consuite"
    t.boolean  "hotel"
    t.boolean  "parties"
    t.boolean  "volunteers"
    t.boolean  "dealers"
    t.boolean  "dock"
    t.boolean  "merchandise"
    t.string   "merged_from_ids", limit: 255
    t.boolean  "merged"
    t.boolean  "nerf_herders"
  end

  create_table "login_logs", force: :cascade do |t|
    t.string   "user_name",  limit: 255
    t.string   "role_name",  limit: 255
    t.string   "comment",    limit: 255
    t.string   "ip",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lost_and_found_items", force: :cascade do |t|
    t.string   "category",        limit: 255
    t.string   "description",     limit: 255
    t.text     "details"
    t.string   "where_last_seen", limit: 255
    t.string   "where_found",     limit: 255
    t.string   "owner_name",      limit: 255
    t.text     "owner_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "rolename",        limit: 255
    t.string   "who_claimed",     limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.string   "for",          limit: 255
    t.string   "phone_number", limit: 255
    t.string   "room_number",  limit: 255
    t.string   "hotel",        limit: 255
    t.integer  "user_id"
    t.text     "message"
    t.boolean  "is_active",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "radio_assignment_audits", force: :cascade do |t|
    t.integer  "radio_id"
    t.integer  "volunteer_id"
    t.string   "state",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "department_id"
  end

  create_table "radio_assignments", force: :cascade do |t|
    t.integer  "radio_id"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
  end

  create_table "radio_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "color",      limit: 255
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "radios", force: :cascade do |t|
    t.string   "number",         limit: 255
    t.string   "notes",          limit: 255
    t.integer  "radio_group_id"
    t.string   "image_filename", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          limit: 255, default: "in"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",                    limit: 255
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "make_hidden_entries",                 default: false
    t.boolean  "rw_secure",                           default: false
    t.boolean  "read_audits",                         default: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", unique: true, using: :btree

  create_table "section_users", force: :cascade do |t|
    t.integer  "section_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "section_users", ["section_id"], name: "index_section_users_on_section_id", using: :btree
  add_index "section_users", ["user_id"], name: "index_section_users_on_user_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "realname",        limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "volunteer_trainings", force: :cascade do |t|
    t.integer  "volunteer_id"
    t.boolean  "radio",          default: false
    t.boolean  "ops_basics",     default: false
    t.boolean  "first_contact",  default: false
    t.boolean  "communications", default: false
    t.boolean  "dispatch",       default: false
    t.boolean  "wandering_host", default: false
    t.boolean  "xo",             default: false
    t.boolean  "ops_subhead",    default: false
    t.boolean  "ops_head",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string   "first_name",               limit: 255
    t.string   "middle_name",              limit: 255
    t.string   "last_name",                limit: 255
    t.string   "address1",                 limit: 255
    t.string   "address2",                 limit: 255
    t.string   "address3",                 limit: 255
    t.string   "city",                     limit: 255
    t.string   "state",                    limit: 255
    t.string   "postal",                   limit: 255
    t.string   "country",                  limit: 255
    t.string   "home_phone",               limit: 255
    t.string   "work_phone",               limit: 255
    t.string   "other_phone",              limit: 255
    t.string   "email",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "can_have_multiple_radios"
  end

  create_table "vsps", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "party"
    t.string   "notes",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "event_sections", "events"
  add_foreign_key "event_sections", "sections"
  add_foreign_key "section_users", "sections"
  add_foreign_key "section_users", "users"
end
