module RideShare
  class Driver
    attr_reader :id, :name, :vin
    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin
      @trips = []
    end

    def get_trips
      return @trips
    end

    def add_trip(trip)
      @trips << trip
    end
  end # end of Driver
end # end of module
