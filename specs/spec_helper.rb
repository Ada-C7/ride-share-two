require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/ride_share_trip.rb'
require_relative '../lib/ride_share_driver.rb'
require_relative '../lib/ride_share_rider.rb'
