require 'csv'
module RideShare
  class Driver
    attr_reader :driver_id, :vin, :name
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @driver_id = hash[:driver_id]
      raise ArgumentError.new("VIn number must contain 17 character only") if hash[:vin].to_s.length != 17
      @vin = hash[:vin]
      @name = hash[:name]
    end

    def trips
      # RideShare::Trips.all_trips_by_driver
    end

    def self.all  #retrieve all drivers from the CSV file
      all_drivers = []
      csv = CSV.read("support/drivers.csv", 'r')
      csv.each do |line|
      #to avoid putting first line from CSV file that contains column name:
        if line[0] == "driver_id"
          next
        end
        hash = {driver_id: line[0].to_i, name: line[1], vin: line[2]}
        all_drivers << Driver.new(hash)
      end
      all_drivers
    end









  end
end

driver_hash = {driver_id: 2, name: "Natalia", license: 3044043, vin: 12213449}
puts RideShare::Driver.all.length
puts RideShare::Driver.all
