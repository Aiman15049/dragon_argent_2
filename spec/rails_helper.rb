require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'devise'
require 'shoulda/matchers'
require 'factory_bot'
require 'simplecov'
require 'coveralls'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '/indices/'
  add_filter 'spec/'
  add_filter 'spec/'
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

FactoryBot.factories.clear
FactoryBot.define do
  sequence(:slug) { |n| "slug#{n}#{rand(1000000)}" }
  sequence(:question) { |n| "title#{n}" }
  sequence(:title) { |n| "title#{n}" }
  sequence(:name) { |n| "name#{n}" }

  sequence(:email) { |n| "test#{n}@test.com" }
  sequence(:server) { |n| "server#{n}" }
  sequence(:project) { |n| "project#{n}" }

end

Dir[Rails.root.join("spec/factories/**/*.rb")].each{|f| load f}
RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
