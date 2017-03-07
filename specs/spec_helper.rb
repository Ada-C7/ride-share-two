require 'simplecov'
SimpleCov.start

gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trips'

require 'csv'
