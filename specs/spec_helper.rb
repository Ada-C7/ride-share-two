require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/drivers'
require_relative '../lib/riders'
require_relative '../lib/trips'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new ## red/green test output
