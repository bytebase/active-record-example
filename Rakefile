require 'active_record'
require 'sinatra/activerecord'
require 'fileutils'
require 'pry'

# Database configuration
db_config = {
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
}

# Set up database connection
ActiveRecord::Base.establish_connection(db_config)

namespace :db do
  desc 'Create the database'
  task :create do
    FileUtils.mkdir_p 'db' unless File.exist?('db')
    FileUtils.touch 'db/development.sqlite3'
    puts "Database created: db/development.sqlite3"
  end

  desc 'Drop the database'
  task :drop do
    File.delete('db/development.sqlite3') if File.exist?('db/development.sqlite3')
    puts "Database dropped"
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

  desc 'Reset the database'
  task reset: [:drop, :create, :migrate]
end

desc 'Start console'
task :console do
  require_relative 'models/user'
  Pry.start
end 