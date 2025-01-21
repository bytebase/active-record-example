--
-- AddCityToUsers : 2
--

BEGIN immediate TRANSACTION;

ALTER TABLE "users" ADD "city" varchar;

INSERT INTO schema_migrations (version) VALUES ('2');
