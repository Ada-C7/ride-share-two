require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'simplecov'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trip'

SimpleCov.start
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
