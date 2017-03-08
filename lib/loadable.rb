require 'csv'

module RideShare
  class Loadable

    def self.all(csv)
      csv = CSV.open(csv, :headers => true, :header_converters => :symbol)
      csv.map { |row| self.new(row.to_hash) }
    end

    def self.find(id)
      self.all.find { |account| account.id == id }
    end
  end
end
