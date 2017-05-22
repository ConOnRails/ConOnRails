CREATE TABLE "audits" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "auditable_id" integer, "auditable_type" varchar(255), "associated_id" integer, "associated_type" varchar(255), "user_id" integer, "user_type" varchar(255), "username" varchar(255), "action" varchar(255), "audited_changes" text, "version" integer DEFAULT 0, "comment" varchar(255), "remote_address" varchar(255), "created_at" datetime);
CREATE TABLE "contacts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "department" varchar(255), "cell_phone" varchar(255), "hotel" varchar(255), "hotel_room" integer, "created_at" datetime, "updated_at" datetime, "can_text" boolean DEFAULT 'f', "position" varchar(255));
CREATE TABLE "departments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "volunteer_id" integer, "radio_group_id" integer, "radio_allotment" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "duty_board_assignments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "duty_board_slot_id" integer, "notes" varchar(255), "created_at" datetime, "updated_at" datetime, "name" varchar(255), "string" varchar(255));
CREATE TABLE "duty_board_groups" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "row" integer, "column" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "duty_board_slots" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "duty_board_group_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "entries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" text, "created_at" datetime, "updated_at" datetime, "user_id" integer, "event_id" integer, "rolename" varchar(255));
CREATE TABLE "event_flag_histories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "event_id" integer, "is_active" boolean DEFAULT 'f', "comment" boolean DEFAULT 'f', "flagged" boolean DEFAULT 'f', "post_con" boolean DEFAULT 'f', "quote" boolean DEFAULT 'f', "sticky" boolean DEFAULT 'f', "emergency" boolean DEFAULT 'f', "medical" boolean DEFAULT 'f', "hidden" boolean DEFAULT 'f', "secure" boolean DEFAULT 'f', "consuite" boolean DEFAULT 'f', "hotel" boolean DEFAULT 'f', "parties" boolean DEFAULT 'f', "volunteers" boolean DEFAULT 'f', "dealers" boolean DEFAULT 'f', "dock" boolean DEFAULT 'f', "merchandise" boolean DEFAULT 'f', "accessibility_and_inclusion" boolean DEFAULT 'f', "allocations" boolean DEFAULT 'f', "first_advisors" boolean DEFAULT 'f', "member_advocates" boolean DEFAULT 'f', "operations" boolean DEFAULT 'f', "programming" boolean DEFAULT 'f', "registration" boolean DEFAULT 'f', "volunteers_den" boolean DEFAULT 'f',"created_at" datetime, "updated_at" datetime, "user_id" integer, "orig_time" datetime, "rolename" varchar(255));
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime, "updated_at" datetime, "is_active" boolean DEFAULT 't', "comment" boolean, "flagged" boolean, "post_con" boolean, "quote" boolean, "sticky" boolean, "emergency" boolean, "medical" boolean, "hidden" boolean, "secure" boolean, "consuite" boolean, "hotel" boolean, "parties" boolean, "volunteers" boolean, "dealers" boolean, "dock" boolean, "merchandise" boolean, "accessibility_and_inclusion" boolean, "allocations" boolean, "first_advisors" boolean, "member_advocates" boolean, "operations" boolean, "programming" boolean, "registration" boolean, "volunteers_den" boolean);
CREATE TABLE "login_logs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_name" varchar(255), "role_name" varchar(255), "comment" varchar(255), "ip" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "lost_and_found_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "category" varchar(255), "description" varchar(255), "details" text, "where_last_seen" varchar(255), "where_found" varchar(255), "owner_name" varchar(255), "owner_contact" text, "created_at" datetime, "updated_at" datetime, "found" boolean DEFAULT 'f', "returned" boolean DEFAULT 'f', "reported_missing" boolean DEFAULT 'f', "user_id" integer, "rolename" varchar(255));
CREATE TABLE "messages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "for" varchar(255), "phone_number" varchar(255), "room_number" varchar(255), "hotel" varchar(255), "user_id" integer, "message" text, "is_active" boolean DEFAULT 't', "created_at" datetime, "updated_at" datetime);
CREATE TABLE "radio_assignment_audits" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "radio_id" integer, "volunteer_id" integer, "state" varchar(255), "created_at" datetime, "updated_at" datetime, "user_id" integer, "department_id" integer);
CREATE TABLE "radio_assignments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "radio_id" integer, "volunteer_id" integer, "created_at" datetime, "updated_at" datetime, "department_id" integer);
CREATE TABLE "radio_groups" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "color" varchar(255), "notes" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "radios" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" varchar(255), "notes" varchar(255), "radio_group_id" integer, "image_filename" varchar(255), "created_at" datetime, "updated_at" datetime, "state" varchar(255) DEFAULT 'in');
CREATE TABLE "roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "write_entries" boolean, "read_hidden_entries" boolean, "add_lost_and_found" boolean, "modify_lost_and_found" boolean, "admin_radios" boolean, "assign_radios" boolean, "admin_users" boolean, "admin_schedule" boolean, "assign_shifts" boolean, "assign_duty_board_slots" boolean, "admin_duty_board" boolean, "created_at" datetime, "updated_at" datetime, "make_hidden_entries" boolean DEFAULT 'f', "rw_secure" boolean DEFAULT 'f', "read_audits" boolean DEFAULT 'f');
CREATE TABLE "roles_users" ("role_id" integer, "user_id" integer);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "realname" varchar(255), "password_digest" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "volunteer_trainings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "volunteer_id" integer, "radio" boolean DEFAULT 'f', "ops_basics" boolean DEFAULT 'f', "first_contact" boolean DEFAULT 'f', "communications" boolean DEFAULT 'f', "dispatch" boolean DEFAULT 'f', "wandering_host" boolean DEFAULT 'f', "xo" boolean DEFAULT 'f', "ops_subhead" boolean DEFAULT 'f', "ops_head" boolean DEFAULT 'f', "created_at" datetime, "updated_at" datetime);
CREATE TABLE "volunteers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar(255), "middle_name" varchar(255), "last_name" varchar(255), "address1" varchar(255), "address2" varchar(255), "address3" varchar(255), "city" varchar(255), "state" varchar(255), "postal" varchar(255), "country" varchar(255), "home_phone" varchar(255), "work_phone" varchar(255), "other_phone" varchar(255), "email" varchar(255), "created_at" datetime, "updated_at" datetime, "user_id" integer);
CREATE INDEX "associated_index" ON "audits" ("associated_id", "associated_type");
CREATE INDEX "auditable_index" ON "audits" ("auditable_id", "auditable_type");
CREATE INDEX "index_audits_on_created_at" ON "audits" ("created_at");
CREATE UNIQUE INDEX "index_roles_users_on_role_id_and_user_id" ON "roles_users" ("role_id", "user_id");
CREATE UNIQUE INDEX "index_users_on_name" ON "users" ("name");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE INDEX "user_index" ON "audits" ("user_id", "user_type");
INSERT INTO schema_migrations (version) VALUES ('20110917200455');

INSERT INTO schema_migrations (version) VALUES ('20110928212009');

INSERT INTO schema_migrations (version) VALUES ('20110928212113');

INSERT INTO schema_migrations (version) VALUES ('20110928212210');

INSERT INTO schema_migrations (version) VALUES ('20111003024032');

INSERT INTO schema_migrations (version) VALUES ('20111018024357');

INSERT INTO schema_migrations (version) VALUES ('20111023023909');

INSERT INTO schema_migrations (version) VALUES ('20111023025123');

INSERT INTO schema_migrations (version) VALUES ('20111023025657');

INSERT INTO schema_migrations (version) VALUES ('20111023030220');

INSERT INTO schema_migrations (version) VALUES ('20111024031119');

INSERT INTO schema_migrations (version) VALUES ('20111104232900');

INSERT INTO schema_migrations (version) VALUES ('20111104235723');

INSERT INTO schema_migrations (version) VALUES ('20111114234458');

INSERT INTO schema_migrations (version) VALUES ('20120204211444');

INSERT INTO schema_migrations (version) VALUES ('20120226183628');

INSERT INTO schema_migrations (version) VALUES ('20120429052751');

INSERT INTO schema_migrations (version) VALUES ('20120429234617');

INSERT INTO schema_migrations (version) VALUES ('20120429235258');

INSERT INTO schema_migrations (version) VALUES ('20120501035447');

INSERT INTO schema_migrations (version) VALUES ('20120506011053');

INSERT INTO schema_migrations (version) VALUES ('20120506040912');

INSERT INTO schema_migrations (version) VALUES ('20120506041011');

INSERT INTO schema_migrations (version) VALUES ('20120506041114');

INSERT INTO schema_migrations (version) VALUES ('20120509034913');

INSERT INTO schema_migrations (version) VALUES ('20120509035640');

INSERT INTO schema_migrations (version) VALUES ('20120517230841');

INSERT INTO schema_migrations (version) VALUES ('20120517235721');

INSERT INTO schema_migrations (version) VALUES ('20120519191319');

INSERT INTO schema_migrations (version) VALUES ('20120522175919');

INSERT INTO schema_migrations (version) VALUES ('20120522175949');

INSERT INTO schema_migrations (version) VALUES ('20120522223105');

INSERT INTO schema_migrations (version) VALUES ('20120602192406');

INSERT INTO schema_migrations (version) VALUES ('20120605180650');

INSERT INTO schema_migrations (version) VALUES ('20120605182523');

INSERT INTO schema_migrations (version) VALUES ('20120605200901');

INSERT INTO schema_migrations (version) VALUES ('20120606212254');

INSERT INTO schema_migrations (version) VALUES ('20120607035915');

INSERT INTO schema_migrations (version) VALUES ('20120607040159');

INSERT INTO schema_migrations (version) VALUES ('20120607042245');

INSERT INTO schema_migrations (version) VALUES ('20120608021550');

INSERT INTO schema_migrations (version) VALUES ('20120608024200');

INSERT INTO schema_migrations (version) VALUES ('20120609201944');

INSERT INTO schema_migrations (version) VALUES ('20120609231137');

INSERT INTO schema_migrations (version) VALUES ('20120610012112');

INSERT INTO schema_migrations (version) VALUES ('20120610012248');

INSERT INTO schema_migrations (version) VALUES ('20120610042439');

INSERT INTO schema_migrations (version) VALUES ('20120610133115');

INSERT INTO schema_migrations (version) VALUES ('20120701234311');