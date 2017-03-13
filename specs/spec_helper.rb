require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

# uncomment this if you hate the new spec
Minitest::Reporters.use!   Minitest::Reporters::SpecReporter.new

require_relative '../lib/driver.rb'
require_relative '../lib/rider.rb'
