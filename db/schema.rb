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

ActiveRecord::Schema[7.0].define(version: 2022_11_01_013706) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", id: :serial, force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.datetime "created_at", precision: nil
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "department"
    t.string "cell_phone"
    t.string "hotel"
    t.integer "hotel_room"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "can_text", default: false
    t.string "position"
  end

  create_table "conventions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_conventions_on_name", unique: true
  end

  create_table "departments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "volunteer_id"
    t.integer "radio_group_id"
    t.integer "radio_allotment"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "duty_board_assignments", id: :serial, force: :cascade do |t|
    t.integer "duty_board_slot_id"
    t.string "notes"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "name"
    t.string "string"
  end

  create_table "duty_board_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "row"
    t.integer "column"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["column"], name: "index_duty_board_groups_on_column"
    t.index ["name"], name: "index_duty_board_groups_on_name", unique: true
    t.index ["row", "column"], name: "index_duty_board_groups_on_row_and_column", unique: true
    t.index ["row"], name: "index_duty_board_groups_on_row"
  end

  create_table "duty_board_slots", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "duty_board_group_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_duty_board_slots_on_name", unique: true
  end

  create_table "entries", id: :serial, force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.integer "event_id"
    t.string "rolename"
    t.index ["created_at"], name: "index_entries_on_created_at"
    t.index ["event_id"], name: "index_entries_on_event_id"
    t.index ["updated_at"], name: "index_entries_on_updated_at"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "event_flag_histories", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.boolean "is_active", default: false
    t.boolean "post_con", default: false
    t.boolean "sticky", default: false
    t.boolean "emergency", default: false
    t.boolean "medical", default: false
    t.boolean "hidden", default: false
    t.boolean "secure", default: false
    t.boolean "consuite", default: false
    t.boolean "hotel", default: false
    t.boolean "parties", default: false
    t.boolean "volunteers", default: false
    t.boolean "dealers", default: false
    t.boolean "dock", default: false
    t.boolean "merchandise", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.datetime "orig_time", precision: nil
    t.string "rolename"
    t.boolean "merged"
    t.boolean "nerf_herders", default: false
    t.boolean "accessibility_and_inclusion", default: false
    t.boolean "allocations", default: false
    t.boolean "first_advisors", default: false
    t.boolean "member_advocates", default: false
    t.boolean "operations", default: false
    t.boolean "programming", default: false
    t.boolean "registration", default: false
    t.boolean "volunteers_den", default: false
    t.boolean "smokers_paradise", default: false
    t.index ["created_at"], name: "index_event_flag_histories_on_created_at"
    t.index ["event_id"], name: "index_event_flag_histories_on_event_id"
    t.index ["updated_at"], name: "index_event_flag_histories_on_updated_at"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "is_active", default: true
    t.boolean "post_con", default: false
    t.boolean "sticky", default: false
    t.boolean "emergency", default: false
    t.boolean "medical", default: false
    t.boolean "hidden", default: false
    t.boolean "secure", default: false
    t.boolean "consuite"
    t.boolean "hotel"
    t.boolean "parties"
    t.boolean "volunteers"
    t.boolean "dealers"
    t.boolean "dock"
    t.boolean "merchandise"
    t.string "merged_from_ids"
    t.boolean "merged"
    t.boolean "nerf_herders"
    t.boolean "accessibility_and_inclusion"
    t.boolean "allocations"
    t.boolean "first_advisors"
    t.boolean "member_advocates"
    t.boolean "operations"
    t.boolean "programming"
    t.boolean "registration"
    t.boolean "volunteers_den"
    t.boolean "smokers_paradise", default: false
    t.index ["created_at"], name: "index_events_on_created_at"
    t.index ["emergency"], name: "index_events_on_emergency"
    t.index ["hotel"], name: "index_events_on_hotel"
    t.index ["is_active"], name: "index_events_on_is_active"
    t.index ["medical"], name: "index_events_on_medical"
    t.index ["secure"], name: "index_events_on_secure"
    t.index ["sticky"], name: "index_events_on_sticky"
    t.index ["updated_at"], name: "index_events_on_updated_at"
  end

  create_table "login_logs", id: :serial, force: :cascade do |t|
    t.string "user_name"
    t.string "role_name"
    t.string "comment"
    t.string "ip"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "lost_and_found_items", id: :serial, force: :cascade do |t|
    t.string "category"
    t.string "description"
    t.text "details"
    t.string "where_last_seen"
    t.string "where_found"
    t.string "owner_name"
    t.text "owner_contact"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.string "rolename"
    t.string "who_claimed"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "for"
    t.string "phone_number"
    t.string "room_number"
    t.string "hotel"
    t.integer "user_id"
    t.text "message"
    t.boolean "is_active", default: true
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "radio_assignment_audits", id: :serial, force: :cascade do |t|
    t.integer "radio_id"
    t.integer "volunteer_id"
    t.string "state"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.integer "department_id"
  end

  create_table "radio_assignments", id: :serial, force: :cascade do |t|
    t.integer "radio_id"
    t.integer "volunteer_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "department_id"
    t.index ["radio_id"], name: "index_radio_assignments_on_radio_id", unique: true
  end

  create_table "radio_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.text "notes"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "radios", id: :serial, force: :cascade do |t|
    t.string "number"
    t.string "notes"
    t.integer "radio_group_id"
    t.string "image_filename"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "state", default: "in"
    t.index ["number"], name: "index_radios_on_number", unique: true
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "write_entries"
    t.boolean "read_hidden_entries"
    t.boolean "add_lost_and_found"
    t.boolean "modify_lost_and_found"
    t.boolean "admin_radios"
    t.boolean "assign_radios"
    t.boolean "admin_users"
    t.boolean "admin_schedule"
    t.boolean "assign_shifts"
    t.boolean "assign_duty_board_slots"
    t.boolean "admin_duty_board"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "make_hidden_entries", default: false
    t.boolean "rw_secure", default: false
    t.boolean "read_audits", default: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", unique: true
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "realname"
    t.string "password_digest"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.string "foreign_type"
    t.index ["foreign_key_name", "foreign_key_id", "foreign_type"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at", precision: nil
    t.text "object_changes"
    t.string "item_subtype"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  create_table "volunteer_trainings", id: :serial, force: :cascade do |t|
    t.integer "volunteer_id"
    t.boolean "radio", default: false
    t.boolean "ops_basics", default: false
    t.boolean "first_contact", default: false
    t.boolean "communications", default: false
    t.boolean "dispatch", default: false
    t.boolean "wandering_host", default: false
    t.boolean "xo", default: false
    t.boolean "ops_subhead", default: false
    t.boolean "ops_head", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "volunteers", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "city"
    t.string "state"
    t.string "postal"
    t.string "country"
    t.string "home_phone"
    t.string "work_phone"
    t.string "other_phone"
    t.string "email"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.boolean "can_have_multiple_radios"
  end

  create_table "vsps", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "party"
    t.string "notes"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_vsps_on_name", unique: true
  end

end
