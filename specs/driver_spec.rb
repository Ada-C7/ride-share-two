require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
# require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/driver'
require_relative '../lib/missingiderror'

describe 'Driver class exits' do
  it 'will find driver class' do
    dude = Rideshare::Driver.new
    dude.class.must_equal Rideshare::Driver
  end
end
