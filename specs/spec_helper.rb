require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/ride_share_2'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
