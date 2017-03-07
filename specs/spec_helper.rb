require 'simplecov'
require 'csv'

SimpleCov.start do
  add_filter "/specs/"
end

require 'pry'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
