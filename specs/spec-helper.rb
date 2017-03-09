require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'simplecov'

require_relative '../lib/ride-share-driver'
require_relative '../lib/ride-share-rider'
require_relative '../lib/ride-share-trips'

SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
