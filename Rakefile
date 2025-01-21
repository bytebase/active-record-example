require 'active_record'
require 'sinatra/activerecord'
require_relative 'config/environment'
require 'fileutils'

namespace :db do
  desc 'Create the database'
  task :create do
    # Ensure the db directory exists
    mkdir_p 'db' unless File.exist?('db')
    
    touch 'db/development.sqlite3'
    puts "Database created: db/development.sqlite3"
  end

  desc 'Drop the database'
  task :drop do
    File.delete('db/development.sqlite3') if File.exist?('db/development.sqlite3')
  end


  desc 'Run migrations'
  task :migrate do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/development.sqlite3'
    )
    migration_context = ActiveRecord::MigrationContext.new('db/migrate', ActiveRecord::SchemaMigration)
    migration_context.migrate
    puts "Database migrations completed successfully"
  end

  desc 'Reset the database'
  task reset: [:drop, :create, :migrate]
end

desc 'Start console'
task :console do
  Pry.start
end 