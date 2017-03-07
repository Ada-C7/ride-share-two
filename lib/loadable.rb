require 'csv'

module RideShare
  class Loadable

    def self.all(csv)
      csv_organized = []
      csv = CSV.open(csv, :headers => true, :header_converters => :symbol) #, :converters => :integer)
      csv.map do |row|
        csv_organized << self.new(row.to_hash)
      end
      csv_organized
    end

    def self.find(id)
      return_object = []
      self.all.each { |account|  return_object = account if account.id == id }
      return_object
    end
  end
end
