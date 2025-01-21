--
-- CreateUsers : 1
--

BEGIN;

CREATE TABLE "users" ("id" bigserial primary key, "name" character varying, "email" character varying, "created_at" timestamp(6) NOT NULL, "updated_at" timestamp(6) NOT NULL);

INSERT INTO schema_migrations (version) VALUES ('1');
