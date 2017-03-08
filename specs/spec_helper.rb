require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/driver'
# require_relative '../lib/rider'
# require_relative '../lib/trip'
