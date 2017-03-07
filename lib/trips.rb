module RideShare

  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end


    def self.all
      trips_array = []
      CSV.read("support/trips.csv", {:headers => true}).each do |trip|
        trips_array << Trip.new(trip[0], trip[1], trip[2], trip[3], trip[4])
      end
      trips_array
    end

    def self.find(id)  #Should we rescue this??
      trip_array = RideShare::Trip.all
      trip_array.each do |trip|
        if id == trip.trip_id
          return trip
        end
      end
      # raise ArgumentError.new "Driver #{id} does not exist"
    end

    def self.find_by_rider(rider_id)
      #class method - find all trip instances for a given Rider ID
      trip_array = RideShare::Trip.all
      riders_trips = []
      trip_array.each do |trip|
        if rider_id == trip.rider_id
          riders_trips << trip
        end
      end
      return riders_trips
    end

    def self.find_by_driver(driver_id)
      #class method - find all trip instances for a given Driver ID
    end

    def find_driver
      #instance method retrieve the associated driver instance through the driver ID
    end

    def find_rider
      #instance method retrieve the associated rider instance through the rider ID
    end



  end
end
