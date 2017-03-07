require 'simplecov'
require 'minitest/autorun'
require 'minitest/reporters'

SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trip'
