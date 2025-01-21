require 'bundler'
Bundler.require
require 'active_record'
require 'sinatra/activerecord'
require 'fileutils'
require 'pry'
require 'capture_migration_sql'

# Database configuration
DB_CONFIG = if ENV['DATABASE_URL']
  # Parse database URL for production
  db = URI.parse(ENV['DATABASE_URL'])
  {
    adapter: 'postgresql',
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  }
else
  # Development configuration
  {
    adapter: 'postgresql',
    host: 'localhost',
    port: ENV['POSTGRES_PORT'] || 5432,
    database: 'testdb',
    username: ENV['POSTGRES_USER'] || 'postgres',
    password: ENV['POSTGRES_PASSWORD'] || 'testpwd1'
  }
end

# Set up database connection
ActiveRecord::Base.establish_connection(DB_CONFIG)

# Load all models
Dir["#{File.dirname(__FILE__)}/../models/*.rb"].each { |file| require file }

require_all 'lib' 