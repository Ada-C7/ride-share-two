require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/rider'
require_relative '../lib/trip'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

describe Rider do
end
