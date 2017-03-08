require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/spec'
require "minitest/autorun"
require "minitest/reporters"
require 'minitest/pride'
require 'minitest/skip_dsl'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/driver"
require_relative "../lib/trip"
require_relative "../lib/rider"
