# do I need to put this in the RideShare module?
# this can be one of those classes that can be used across lots of programs
# require 'csv'
# module RideShare
#   class FileData
#     def initialize
#     end
#
#     def self.read_csv(csv_file)
#       data = CSV.read(csv_file)
#       data.shift
#       return data
#     end
#   end
# end

# having a hard time figuring out how I want this class to look
# initialize an instance everytime you want to read/open a new file?
# could send any file - it tests for types - confirms it exists
# a bunch of read methods could live here depending on the type of file that you pass?
require 'csv'
# require'file'

class FileData
  attr_reader :csv_file

  def initialize(csv_file)
    raise ArgumentError unless File.file?(csv_file)
    @csv_file = csv_file
  end

  def read_csv_and_remove_headings
    data = CSV.read(@csv_file)
    # this line removes headings
    data.shift
    return data
  end
end

# fake = FileData.new("../support/fake.csv")
# p fake

# this will raise an argument error cause it wont pass the guard clause
# string = FileData.new('hello')
# p string
