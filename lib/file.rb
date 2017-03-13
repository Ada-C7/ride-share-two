require 'csv'
#this class creates a FileData object which is an object that has csv_file and
# you can call read method(s) on this object 
class FileData
  attr_reader :csv_file

  def initialize(csv_file)
    raise ArgumentError unless File.file?(csv_file)
    @csv_file = csv_file
  end

  def read_csv_and_remove_headings
    CSV.read(@csv_file)[1..-1]
  end
end
