# do I need to put this in the RideShare module?
# this can be one of those classes that can be used across lots of programs
require 'csv'
module RideShare
  class FileData
    def initialize
    end

    def self.read_csv(csv_file)
      data = CSV.read(csv_file)
      data.shift
      return data
    end
  end
end
