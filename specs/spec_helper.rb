require 'simplecov'
SimpleCov.start do
  add_filter "/specs/"
end

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
