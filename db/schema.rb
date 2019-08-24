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

ActiveRecord::Schema.define(version: 20190823220241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "department"
    t.string   "cell_phone"
    t.string   "hotel"
    t.integer  "hotel_room"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_text",   default: false
    t.string   "position"
  end

  create_table "conventions", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.integer  "volunteer_id"
    t.integer  "radio_group_id"
    t.integer  "radio_allotment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duty_board_assignments", force: :cascade do |t|
    t.integer  "duty_board_slot_id"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "string"
  end

  create_table "duty_board_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "row"
    t.integer  "column"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["column"], name: "index_duty_board_groups_on_column", using: :btree
    t.index ["row", "column"], name: "index_duty_board_groups_on_row_and_column", unique: true, using: :btree
    t.index ["row"], name: "index_duty_board_groups_on_row", using: :btree
  end

  create_table "duty_board_slots", force: :cascade do |t|
    t.string   "name"
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
    t.string   "rolename"
    t.index ["created_at"], name: "index_entries_on_created_at", using: :btree
    t.index ["event_id"], name: "index_entries_on_event_id", using: :btree
    t.index ["updated_at"], name: "index_entries_on_updated_at", using: :btree
    t.index ["user_id"], name: "index_entries_on_user_id", using: :btree
  end

  create_table "event_flag_histories", force: :cascade do |t|
    t.integer  "event_id"
    t.boolean  "is_active",                   default: false
    t.boolean  "post_con",                    default: false
    t.boolean  "sticky",                      default: false
    t.boolean  "emergency",                   default: false
    t.boolean  "medical",                     default: false
    t.boolean  "hidden",                      default: false
    t.boolean  "secure",                      default: false
    t.boolean  "consuite",                    default: false
    t.boolean  "hotel",                       default: false
    t.boolean  "parties",                     default: false
    t.boolean  "volunteers",                  default: false
    t.boolean  "dealers",                     default: false
    t.boolean  "dock",                        default: false
    t.boolean  "merchandise",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "orig_time"
    t.string   "rolename"
    t.boolean  "merged"
    t.boolean  "nerf_herders",                default: false
    t.boolean  "accessibility_and_inclusion", default: false
    t.boolean  "allocations",                 default: false
    t.boolean  "first_advisors",              default: false
    t.boolean  "member_advocates",            default: false
    t.boolean  "operations",                  default: false
    t.boolean  "programming",                 default: false
    t.boolean  "registration",                default: false
    t.boolean  "volunteers_den",              default: false
    t.index ["created_at"], name: "index_event_flag_histories_on_created_at", using: :btree
    t.index ["event_id"], name: "index_event_flag_histories_on_event_id", using: :btree
    t.index ["updated_at"], name: "index_event_flag_histories_on_updated_at", using: :btree
  end

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
    t.string   "merged_from_ids"
    t.boolean  "merged"
    t.boolean  "nerf_herders"
    t.boolean  "accessibility_and_inclusion"
    t.boolean  "allocations"
    t.boolean  "first_advisors"
    t.boolean  "member_advocates"
    t.boolean  "operations"
    t.boolean  "programming"
    t.boolean  "registration"
    t.boolean  "volunteers_den"
    t.index ["created_at"], name: "index_events_on_created_at", using: :btree
    t.index ["emergency"], name: "index_events_on_emergency", using: :btree
    t.index ["hotel"], name: "index_events_on_hotel", using: :btree
    t.index ["is_active"], name: "index_events_on_is_active", using: :btree
    t.index ["medical"], name: "index_events_on_medical", using: :btree
    t.index ["secure"], name: "index_events_on_secure", using: :btree
    t.index ["sticky"], name: "index_events_on_sticky", using: :btree
    t.index ["updated_at"], name: "index_events_on_updated_at", using: :btree
  end

  create_table "login_logs", force: :cascade do |t|
    t.string   "user_name"
    t.string   "role_name"
    t.string   "comment"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lost_and_found_items", force: :cascade do |t|
    t.string   "category"
    t.string   "description"
    t.text     "details"
    t.string   "where_last_seen"
    t.string   "where_found"
    t.string   "owner_name"
    t.text     "owner_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "rolename"
    t.string   "who_claimed"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "for"
    t.string   "phone_number"
    t.string   "room_number"
    t.string   "hotel"
    t.integer  "user_id"
    t.text     "message"
    t.boolean  "is_active",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "radio_assignment_audits", force: :cascade do |t|
    t.integer  "radio_id"
    t.integer  "volunteer_id"
    t.string   "state"
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
    t.string   "name"
    t.string   "color"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "radios", force: :cascade do |t|
    t.string   "number"
    t.string   "notes"
    t.integer  "radio_group_id"
    t.string   "image_filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          default: "in"
  end

  create_table "roles", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "make_hidden_entries",     default: false
    t.boolean  "rw_secure",               default: false
    t.boolean  "read_audits",             default: false
    t.index ["name"], name: "index_roles_on_name", unique: true, using: :btree
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", unique: true, using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "realname"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "can_have_multiple_radios"
  end

  create_table "vsps", force: :cascade do |t|
    t.string   "name"
    t.boolean  "party"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
