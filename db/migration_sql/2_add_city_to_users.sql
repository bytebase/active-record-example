--
-- AddCityToUsers : 2
--

BEGIN;

ALTER TABLE "users" ADD "city" character varying;

INSERT INTO schema_migrations (version) VALUES ('2');
