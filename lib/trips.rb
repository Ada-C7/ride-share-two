module RideShare

  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = error_checked_rating(rating)
    end



    def self.all
      trips_array = []
      CSV.read("support/trips.csv", {:headers => true}).each do |trip|
        begin
          trips_array << Trip.new(trip[0], trip[1], trip[2], trip[3], trip[4])
        rescue
          trips_array << Trip.new(trip[0], trip[1], trip[2], trip[3], nil)
        end
      end
      trips_array
    end

    def self.find(id)  #Should we rescue this??
      trip_array = self.all
      trip_array.each do |trip|
        if id == trip.trip_id
          return trip
        end
      end
      # raise ArgumentError.new "Driver #{id} does not exist"
    end

    def self.find_by_rider(rider_id)
      #class method - find all trip instances for a given Rider ID
      some_array = []
      trip_array = self.all
      trip_array.each do |trip|
        if rider_id == trip.rider_id
          some_array << trip
        end
      end
      return some_array
    end

    def self.find_by_driver(driver_id)
      #class method - find all trip instances for a given Driver ID
      some_array = []
      trip_array = RideShare::Trip.all
      trip_array.each do |trip|
        if driver_id == trip.driver_id
          some_array << trip
        end
      end
      return some_array
    end

    def find_driver
      id = driver_id.to_s
      begin
        RideShare::Driver.find(id)
      rescue ArgumentError
        return nil
      end
      #instance method retrieve the associated driver instance through the driver ID
    end

    def find_rider
      id = rider_id.to_s
      RideShare::Rider.find(id)
      #instance method retrieve the associated rider instance through the rider ID
    end


    #private
    def error_checked_rating(rating)
      if (1..5).include?(rating.to_i)
        return rating
      elsif !(1..5).include?(rating.to_i)
        return nil
      else
        raise ArgumentError.new("Rating must be 1-5")
      end
    end

  end
end
