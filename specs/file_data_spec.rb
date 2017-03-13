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
  end
end
