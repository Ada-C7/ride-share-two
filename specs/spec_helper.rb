require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/drivers'
require_relative '../lib/riders'
require_relative '../lib/trips'
require 'csv'
