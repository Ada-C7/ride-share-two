require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# rainbow version of test output
#require 'minitest/pride'
require 'csv'
require 'simplecov'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

SimpleCov.start

#colorized version of test output
#Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trip'
require_relative '../lib/invalid_vin_error'
