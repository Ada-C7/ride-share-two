require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/riders.rb'
require_relative '../lib/drivers.rb'
require_relative '../lib/trip.rb'
