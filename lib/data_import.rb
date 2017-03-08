require 'csv'

module DataImport

  def self.import_attributes(filename)
    CSV.read(
      filename,
      headers: true,
      header_converters: :symbol,
      converters: :all
    ).map { |line| line.to_h }
  end

end
