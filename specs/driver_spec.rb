require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe Driver do
  describe "Driver#initialize" do

    it "takes arguments:" do
      
    end
  end
end
