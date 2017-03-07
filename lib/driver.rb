module RideShare

  class Driver
  attr_reader :id, :name, :vin

    # creates driver that has an ID, name, and vehicle identification number (vin)
    def initialize(id, name, vin)
      @id = id.to_i
      @name = name
      @vin = vin.length == 17 ? vin : "00000000000000000"
    end


    # retreives lists of all trips for specific driver
    def trips
      RideShare::Trip.drivers_trips(@id)
    end


    # calculates an average rating of all trips for specific driver
    def avg_rating
      # total = 0
      #
      # trips.each do | trip |
      #   total += trip.rating
      # end
      #
      # avg_rating / RideShare::Trip.drivers_trips.length
    end


    # retreives all drivers from CSV
    def self.all
      all_drivers = []

      CSV.open("support/drivers.csv").each do | line |
        id = line[0]
        name = line[1]
        vin = line[2]

        all_drivers << RideShare::Driver.new(id, name, vin)
      end

      return all_drivers
    end


    # finds driver using the driver's id
    def self.find(driver_id)
      all_drivers = RideShare::Driver.all

      all_drivers.each do | driver |
        return driver if driver_id == driver.id
      end

      raise ArgumentError.new("Invalid Driver ID")
    end

  end

end
