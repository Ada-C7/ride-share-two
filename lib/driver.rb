require_relative 'rideshare'

module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      raise ArgumentError.new("The ID is invalid.") if id.class != Integer
      raise ArgumentError.new("The name is invalid.") if name.class != String
      raise InvalidVinError.new("The VIN number is invalid.") if vin.length != 17 || !vin.upcase.match(/^[0-9A-Z]+$/)

      @id = id
      @name = name
      @vin = vin.upcase
    end


    def self.all
      CSV.read("support/drivers.csv", headers: true).map do | line |
        RideShare::Driver.new(line[0].to_i, line[1], line[2])
      end
    end

    def self.find(driver_ID)
      self.all.find { |driver| driver.id == driver_ID }
    end


    # trips(driver_ID)
    # called on driver object
    # given driver_ID
    # call trip.find_drivers(driver_ID)
    # returns all driver's trips

    # average_rating
    # called on driver object
    # call driver's trips(driver_ID)
    # returns all driver's trips
    # map driver trips into driver ratings array
    # find & return average


  end

end
