# frozen_string_literal: true

require 'active_record'
require 'sqlite3'
require 'factory_bot'
require 'database_cleaner'

DB_PATH = "#{__dir__}/db/test.db"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    SQLite3::Database.new(DB_PATH)
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: DB_PATH)
    require_relative './db/schema'
    FactoryBot.find_definitions
  end

  config.after(:suite) do
    File.delete(DB_PATH)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
