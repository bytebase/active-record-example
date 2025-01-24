--
-- CreateSalary : 20240320121000
--

BEGIN;

CREATE TABLE "salary" ("id" bigserial primary key, "name" character varying, "amount" integer, "created_at" timestamp(6) NOT NULL, "updated_at" timestamp(6) NOT NULL);

INSERT INTO schema_migrations (version) VALUES ('20240320121000');
