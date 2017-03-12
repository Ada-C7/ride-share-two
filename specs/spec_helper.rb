require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative '../lib/driver'
require_relative '../lib/trip'
require_relative '../lib/rider'
