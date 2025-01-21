require 'active_record'
require 'sinatra/activerecord'
require 'fileutils'
require 'pry'
require 'capture_migration_sql'

# Database configuration
db_config = {
  adapter: 'postgresql',
  host: 'localhost',
  port: ENV['POSTGRES_PORT'] || 5432,
  database: 'testdb',
  username: ENV['POSTGRES_USER'] || 'postgres',
  password: ENV['POSTGRES_PASSWORD'] || 'testpwd1'
}

# Set up database connection
ActiveRecord::Base.establish_connection(db_config)

namespace :db do
  desc 'Create the database'
  task :create do
    begin
      # Connect to postgres database to create new database
      temp_config = db_config.merge(database: 'postgres')
      ActiveRecord::Base.establish_connection(temp_config)
      ActiveRecord::Base.connection.create_database(db_config[:database])
      puts "Database created: #{db_config[:database]}"
    rescue ActiveRecord::DatabaseAlreadyExists
      puts "Database already exists"
    end
  end

  desc 'Drop the database'
  task :drop do
    begin
      # Connect to postgres database to drop the target database
      temp_config = db_config.merge(database: 'postgres')
      ActiveRecord::Base.establish_connection(temp_config)
      ActiveRecord::Base.connection.drop_database(db_config[:database])
      puts "Database dropped"
    rescue ActiveRecord::DatabaseNotFound
      puts "Database doesn't exist"
    end
  end

  desc 'Run migrations'
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
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

  desc 'Generate SQL files for migrations'
  task :to_sql do
    # Ensure the migration_sql directory exists
    FileUtils.mkdir_p 'db/migration_sql' unless File.exist?('db/migration_sql')
    
    # Configure SQL capture to use original migration filenames
    CaptureMigrationSql.capture(
      directory: "db/migration_sql",
      starting_with: nil
    )
    
    # Run migrations to generate SQL
    Rake::Task["db:migrate"].invoke
    
    puts "\nSQL files generated in db/migration_sql/"
  end

  desc 'Reset the database'
  task reset: [:drop, :create, :to_sql]
end

desc 'Start console'
task :console do
  require_relative 'models/user'
  Pry.start
end 