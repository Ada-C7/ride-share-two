require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../carmmunity.rb'
