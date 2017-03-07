require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/driver'
require_relative '../lib/rider'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

describe Trip do
end
