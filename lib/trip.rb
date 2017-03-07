module RideShare

  class Trip
  attr_reader :id, :rider_id, :driver_id, :date, :rating

    # creates trips that have an ID, rider ID, driver ID, date, and rating
    def initialize(id, rider_id, driver_id, date, rating)
      @id = id
      @rider_id = rider_id
      @driver_id = driver_id
      @date = date
      @rating = (1..5).include?(rating) ? rating : 3
    end


    # retrieve the associated driver instance using the driver ID
    def trip_driver
      RideShare::Driver.find(@driver_id)
    end


    # retrieve the associated rider instance using the rider ID
    def trip_rider
      RideShare::Rider.find(@rider_id)
    end


    # retrieve all trips from the CSV file
    def self.all
      all_trips = []

      CSV.open("support/trips.csv").each do | line |
        id = line[0].to_i
        rider_id = line[1].to_i
        driver_id = line[2].to_i
        date = line[3]
        rating = line[4].to_i

        all_trips << RideShare::Trip.new(id, rider_id, driver_id, date, rating)
      end

      return all_trips
    end


    # find all trip instances for a given driver ID
    def self.drivers_trips(driver_id)
      all_trips = RideShare::Trip.all

      all_trips.reject! { | trip | driver_id != trip.driver_id }

      if all_trips.length >= 1 # consider making new exception
        return all_trips
      else
        raise ArgumentError.new("Invalid Driver ID")
      end
    end


    # find all trip instances for a given rider ID
    def self.riders_trips(rider_id)
      all_trips = RideShare::Trip.all

      all_trips.reject! { | trip | rider_id != trip.rider_id }

      if all_trips.length >= 1
        return all_trips
      else
        raise ArgumentError.new("Invalid Rider ID") # consider making new exception
      end
    end

  end

end
