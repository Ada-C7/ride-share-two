require 'simplecov'
SimpleCov.start

require 'csv'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
require_relative '../lib/drivers'
require_relative '../lib/riders'
require_relative '../lib/trips'
require_relative '../lib/invalid_vin_error'
