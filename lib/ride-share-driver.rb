require 'csv'

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin

    end

    def self.all
      all_drivers = []

      csv_data = CSV.read("support/drivers.csv")
      csv_data.shift

      csv_data.each do |line|
        all_drivers << Driver.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      return all_drivers
    end

    def self.find(id) # find a specific driver using their numeric ID
      drivers = Driver.all
      return drivers.find {|driver| driver.id == id }
    end

    def self.find_trips(id)
      # will need to search through all trip data and fill an empty array with the
      # trip info for all the trips that one driver took
      driver_trips = []
      # access self.all (Trips class) array to find the driver ids
      csv_data.each do |line|
        driver_trips << Driver.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      return all_drivers
    end

    def to_s
      "id: #{ @id }, name: #{ @name }, VIN: #{ @vin }"
    end
  end
