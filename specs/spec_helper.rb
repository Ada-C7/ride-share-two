require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
# didn't include these in Scrabble and it still worked, why?
require_relative '../lib/driver.rb'
require_relative '../lib/rider.rb'
require_relative '../lib/trips.rb'
