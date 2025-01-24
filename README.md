# Active Record GitOps Example

A demonstration of Active Record integration with Bytebase API and GitHub Actions GitOps workflow.

# Workflow

1. Developer creates a new migration file in `db/migrate/` and applies to the local database.
1. When developer finishes the local development, they can run `rake db:to_sql` to generate the raw SQL file. The file
   is co-located with the `.rb` migration file.
1. Developer creates a PR ([Sample](https://github.com/bytebase/active-record-example/pull/5/files)) with the `.rb` and `.sql` files for review.
1. `bytebase-review-sql.yml` GitHub action kicks off and post any warnings. Below shows 2 warnings: `NOT NULL` violation and missing `CONCURRENT` when creating index. These rules are [configurable](https://www.bytebase.com/docs/sql-review/review-rules/).

   ![sql-review](https://raw.githubusercontent.com/bytebase/active-record-example/refs/heads/main/assets/sql-review.webp)

1. Back and forth between the developer and the reviewer.
1. PR is approved and merged to the main branch.
1. `bytebase-roll-out-sql.yml` GitHub action kicks off:

   1. Create a Bytebase release.

      ![release](https://raw.githubusercontent.com/bytebase/active-record-example/refs/heads/main/assets/release.webp)

   1. Create a Bytebase plan based on the release. The plan can target multiple databases. Thus the plan may contain multiple stages and each stage may contain multiple tasks.

   1. Roll out the plan.

      ![rollout](https://raw.githubusercontent.com/bytebase/active-record-example/refs/heads/main/assets/rollout.webp)

   1. Rollout completes and Bytebase records the revision.

      ![revision](https://raw.githubusercontent.com/bytebase/active-record-example/refs/heads/main/assets/revision.webp)

# Note
