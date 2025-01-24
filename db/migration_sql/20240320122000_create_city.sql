--
-- CreateCity : 20240320122000
--

BEGIN;

CREATE TABLE "city" ("id" bigserial primary key, "name" character varying, "country" character varying, "created_at" timestamp(6) NOT NULL, "updated_at" timestamp(6) NOT NULL);

INSERT INTO schema_migrations (version) VALUES ('20240320122000');
