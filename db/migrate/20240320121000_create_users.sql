--
-- CreateUsers : 20240320121000
--

BEGIN;

CREATE TABLE "users" ("id" bigserial primary key, "name" character varying, "email" character varying NOT NULL, "created_at" timestamp(6) NOT NULL, "updated_at" timestamp(6) NOT NULL);

CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");

INSERT INTO schema_migrations (version) VALUES ('20240320121000');
