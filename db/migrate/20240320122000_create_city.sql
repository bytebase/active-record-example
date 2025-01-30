--
-- CreateCity : 20240320122000
--

BEGIN;

CREATE TABLE "city" ("id" bigserial primary key, "name" character varying NOT NULL, "created_at" timestamp(6) NOT NULL, "updated_at" timestamp(6) NOT NULL);

CREATE UNIQUE INDEX "index_city_on_name" ON "city" ("name");

INSERT INTO schema_migrations (version) VALUES ('20240320122000');
