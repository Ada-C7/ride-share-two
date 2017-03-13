require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!

require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trip'
require_relative '../lib/invalid_file_error.rb'
require_relative '../lib/invalid_vin_error'
require 'pry'
