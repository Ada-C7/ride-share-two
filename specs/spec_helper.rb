require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trip'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new
