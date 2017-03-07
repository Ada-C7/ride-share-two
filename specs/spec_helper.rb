require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative '../lib/Drivers.rb'
require_relative '../lib/Riders.rb'
require_relative '../lib/Trips.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
