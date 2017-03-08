require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'csv'
require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trip'
