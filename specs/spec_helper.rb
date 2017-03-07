require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative '../lib/driver'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
