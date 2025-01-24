require 'active_record'
require 'sinatra/activerecord'
require 'fileutils'
require 'pry'
require 'capture_migration_sql'
require_relative 'config/environment'

namespace :db do
  desc 'Create the database'
  task :create do
    begin
      # Connect to postgres database to create new database
      temp_config = DB_CONFIG.merge(database: 'postgres')
      ActiveRecord::Base.establish_connection(temp_config)
      ActiveRecord::Base.connection.create_database(DB_CONFIG[:database])
      puts "Database created: #{DB_CONFIG[:database]}"
    rescue ActiveRecord::DatabaseAlreadyExists
      puts "Database already exists"
    end
  end

  desc 'Drop the database'
  task :drop do
    begin
      # Connect to postgres database to drop the target database
      temp_config = DB_CONFIG.merge(database: 'postgres')
      ActiveRecord::Base.establish_connection(temp_config)
      ActiveRecord::Base.connection.drop_database(DB_CONFIG[:database])
      puts "Database dropped"
    rescue ActiveRecord::DatabaseNotFound
      puts "Database doesn't exist"
    end
  end

  desc 'Run migrations'
  task :migrate do
    ActiveRecord::Base.establish_connection(DB_CONFIG)
    ActiveRecord::Base.connection
    
    unless ActiveRecord::Base.connection.table_exists?('schema_migrations')
      ActiveRecord::Base.connection.create_table(:schema_migrations) do |t|
        t.string :version, null: false
      end
      ActiveRecord::Base.connection.add_index :schema_migrations, :version, unique: true
    end
    
    migration_context = ActiveRecord::MigrationContext.new('db/migrate/')
    migration_context.migrate
    puts "Database migrations completed successfully"
  end

  desc 'Show current schema'
  task :schema do
    puts "\nCurrent Schema:"
    puts "==============="
    ActiveRecord::Base.connection.tables.each do |table|
      puts "\nTable: #{table}"
      puts ActiveRecord::Base.connection.columns(table).map { |c| 
        "  #{c.name} (#{c.type})"
      }
    end
  end

  desc 'Show migration versions'
  task :versions do
    ActiveRecord::Base.establish_connection(DB_CONFIG)
    if ActiveRecord::Base.connection.table_exists?('schema_migrations')
      versions = ActiveRecord::Base.connection.select_all('SELECT version FROM schema_migrations ORDER BY version').rows.flatten
      if versions.any?
        puts "\nApplied migrations:"
        puts "==================="
        versions.each { |version| puts version }
      else
        puts "No migrations have been applied yet."
      end
    else
      puts "Schema migrations table does not exist. Run migrations first."
    end
  end

  desc 'Generate SQL files for migrations'
  task :to_sql do
    
    # Configure SQL capture to use original migration filenames
    CaptureMigrationSql.capture(
      directory: "db/migrate",
      starting_with: nil
    )
    
    # Run migrations to generate SQL
    Rake::Task["db:migrate"].invoke
    
    puts "\nSQL files generated in db/migrate/"
  end

  desc 'Reset the database'
  task reset: [:drop, :create, :to_sql]
end

desc 'Start console'
task :console do
  Pry.start
end 