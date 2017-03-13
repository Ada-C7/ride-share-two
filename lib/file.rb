require 'csv'
class FileData
  attr_reader :csv_file

  def initialize(csv_file)
    raise ArgumentError unless File.file?(csv_file)
    @csv_file = csv_file
  end

  # you could work on this method - look at examples where you expect headings
  def read_csv_and_remove_headings
    CSV.read(@csv_file)[1..-1]
  end
end
