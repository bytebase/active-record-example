--
-- AddCityToUsers : 20240320123100
--

BEGIN;

ALTER TABLE "users" ADD "city" character varying;

INSERT INTO schema_migrations (version) VALUES ('20240320123100');
