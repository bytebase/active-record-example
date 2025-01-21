require 'active_record'
require_relative 'models/user'

# Database configuration
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

# Print users table schema
puts "\nUsers Table Schema:"
User.connection.columns(:users).each do |column|
  puts "  #{column.name}: #{column.type}"
end

# Print migration history schema and data
puts "\nMigration Table Schema:"
User.connection.columns(:schema_migrations).each do |column|
  puts "  #{column.name}: #{column.type}"
end

puts "\nMigration History:"
schema_migrations = ActiveRecord::Base.connection.execute("SELECT * FROM schema_migrations")
schema_migrations.each do |migration|
  puts "\n  Migration:"
  migration.each do |column, value|
    puts "    #{column}: #{value}"
  end
end