require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/ride_share'
require 'csv'
require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
