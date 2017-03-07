require_relative 'rideshare'

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      raise ArgumentError.new("The ID is invalid.") if id.class != Integer
      raise ArgumentError.new("The name is invalid.") if name.class != String
      raise InvalidVinError.new("The VIN number is invalid.") if vin.length != 17 || !vin.upcase.match(/[0-9A-Z]/)

      @id = id
      @name = name
      @vin_num = vin
    end


    # self.all
    # returns array of all instances of driver

    # self.find(driver_ID)
    # given driver_ID, returns a driver

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
