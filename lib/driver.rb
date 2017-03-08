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
      return RideShare::Trip.drivers_trips(@id)
    end


    # calculates an average rating of all trips for specific driver
    def avg_rating
      return ratings_sum / num_trips.to_f
    end


    # retreives all drivers from CSV and initializes new Driver from each line
    def self.all
      all_drivers = []

      CSV.foreach("support/drivers.csv", :headers => true) do | line |
        id = line[0]
        name = line[1]
        vin = line[2]

        all_drivers << RideShare::Driver.new(id, name, vin)
      end

      return all_drivers
    end


    # finds driver using the driver's id
    def self.find(driver_id)
      RideShare::Driver.all.each do | driver |
        return driver if driver_id == driver.id
      end

      raise ArgumentError.new("Invalid Driver ID in RideShare::Driver #find")
    end


    private


    # calculates number of trips taken by instance of driver
    def num_trips
      return trips.length
    end


    # calculates sum of ratings for instance of driver
    def ratings_sum
      sum = 0

      trips.each do | trip |
        sum += trip.rating
      end

      return sum
    end

  end

end
