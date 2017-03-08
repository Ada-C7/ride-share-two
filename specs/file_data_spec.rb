# require 'simplecov'
# SimpleCov.start
# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative './spec_helper.rb'
require_relative '../lib/file'

describe "FileData" do


  describe "File#initialize" do

    let(:file) { FileData.new('./support/trips.csv') }
    let(:fake_file) { FileData.new('./support/trips_fake.csv') }
    let(:pass_string) { FileData.new('hello') }

    it "checks that the file exists" do
      proc {
        fake_file
      }.must_raise ArgumentError
    end

    it "doesn't accept input other than file" do
      proc {
        pass_string
      }.must_raise ArgumentError
    end

    it "must be instance of a FileData" do
      file.must_be_instance_of FileData
    end

    it "must respond to csv_file" do
      file.must_respond_to :csv_file
    end
  end

  describe "File#read_csv_and_remove_headings" do

    let(:file) { FileData.new('./support/trips.csv') }

    it "must return an array of arrays" do
      file.read_csv_and_remove_headings.must_be_instance_of Array
      file.read_csv_and_remove_headings[0].must_be_instance_of Array
    end

    # wont initialize unless this thing is a file so this isn't needed
    # it "raises an error if not given csv_file" do
    #   proc {
    #     pass_string.read_csv_and_remove_headings()
    #  }.must_raise Errno::ENOENT
    # end

  end
end



  # specs for File-read with read as class method
  # describe "File#read_csv_and_remove_headings" do
  #
  #   let(:data) { RideShare::FileData.read_csv_and_remove_headings('./support/trips.csv') }
  #
  #   it "returns an array" do
  #     data.must_be_instance_of Array
  #   end
  #
  #   it "returns an array of arrays" do
  #     data[0].must_be_instance_of Array
  #   end
  #
  #   it "requires a csv file" do
  #     proc {
  #       RideShare::FileData.read_csv_and_remove_headings('hello')
  #     }.must_raise Errno::ENOENT
  #   end
  # end
