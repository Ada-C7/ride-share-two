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
