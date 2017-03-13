require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'


# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/driver'
require_relative '../lib/trips'
require_relative '../lib/rider'
