require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative "../ride_share"
# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
