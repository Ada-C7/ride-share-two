
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'simplecov'
SimpleCov.start do


# Require_relative your lib files here!
require_relative '../lib/driver.rb'
require_relative '../lib/rider.rb'
require_relative '../lib/trip.rb'
end
