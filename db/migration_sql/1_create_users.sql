--
-- CreateUsers : 1
--

BEGIN immediate TRANSACTION;

CREATE TABLE "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "email" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);

INSERT INTO schema_migrations (version) VALUES ('1');
