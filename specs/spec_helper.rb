require 'simplecov'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
# Add simplecov


SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/driver'
require_relative '../lib/trip'
require_relative '../lib/rider'
