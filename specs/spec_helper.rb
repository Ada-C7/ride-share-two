require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../ride_share'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
