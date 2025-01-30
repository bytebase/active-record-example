--
-- CreateStores : 20240320123000
--

BEGIN;

CREATE TABLE "stores" ("id" bigserial primary key, "name" character varying, "created_at" timestamp(6) NOT NULL, "updated_at" timestamp(6) NOT NULL);

CREATE UNIQUE INDEX "index_stores_on_name" ON "stores" ("name");

INSERT INTO schema_migrations (version) VALUES ('20240320123000');
