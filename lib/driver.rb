require_relative 'trip'

module RideShare

  class Driver
  attr_reader :id, :name, :vin

    # creates driver that has an ID, name, and vehicle identification number (vin)
    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin.length == 17 ? vin : "00000000000000000"
    end

    # retreives lists of all trips for specific driver
    def trips
    end

    # calculates an average rating of all trips for specific driver
    def avg_rating
    end

    # retreives all drivers from CSV
    def self.all
    end

    # finds driver using the driver's id
    def self.find(id)
    end

  end

end
