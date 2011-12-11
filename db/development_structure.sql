CREATE TABLE "entries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" text, "created_at" datetime, "updated_at" datetime, "user_id" integer, "event_id" integer);
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime, "updated_at" datetime, "is_active" boolean DEFAULT 't', "comment" boolean, "flagged" boolean, "post_con" boolean, "quote" boolean, "sticky" boolean, "emergency" boolean, "medical" boolean, "hidden" boolean, "secure" boolean, "consuite" boolean, "hotel" boolean, "parties" boolean, "volunteers" boolean, "dealers" boolean, "dock" boolean, "merchandise" boolean);
CREATE TABLE "lost_and_found_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "category" varchar(255), "description" varchar(255), "details" text, "where_last_seen" varchar(255), "where_found" varchar(255), "owner_name" varchar(255), "owner_contact" text, "created_at" datetime, "updated_at" datetime, "found" boolean DEFAULT 'f', "returned" boolean DEFAULT 'f', "reported_missing" boolean DEFAULT 'f');
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "realname" varchar(255), "password_digest" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_users_on_name" ON "users" ("name");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
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