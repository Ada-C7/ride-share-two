module RideShare

  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
      raise ArgumentError.new("Rating must be between 1 and 5") if rating.length < 1 || rating.length > 5
    end


    def self.all
      
    end
    #Each trip has ID, rider_id, driver_id, date, rating
    #Rating must be between 1-5
    #Retrieve driver instance through driver_id
    #retrieve driver instance through rider_id

    #Reads CSV file in all method
    #create method that uses method from driver to retrieve the associated driver instance
    #create method that uses method from rider to retrieve the associated rider instance

    #create a method to retrieve all trips by driver_id
    #create a method to retrieve all trips by rider_id
  end

end
