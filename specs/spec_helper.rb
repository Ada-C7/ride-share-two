require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
# require 'minitest/skip_dsl'

# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/module'
# require_relative '../lib/trip.rb'
# require_relative '../lib/rider.rb'
# require_relative '../lib/missingiderror'
