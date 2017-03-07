require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/trip'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "FileData" do

  describe "File#read_csv" do

    it "returns an Array" do
      data = RideShare::FileData.read_csv('./support/trips.csv')
      data.must_be_instance_of Array
    end

    # this will move to csv file specs
    it "requires a csv file" do
      proc {
        RideShare::FileData.read_csv('hello')
      }.must_raise Errno::ENOENT
    end
  end
end
