module RideShare
  class Trip
    # def initialize(id, driver_id, rider_id, date, rating)
    #   @id = id
    #   @driver_id = driver_id
    #   @rider_id = rider_id
    #   @date = date
    #   @rating = rating
    # end


    def self.read_csv
      @@trips = CSV.read("support/trips.csv")[1..-1].map do |array_of_details|
        {
          id: array_of_details[0].to_i,
          driver_id:array_of_details[1].to_i,
          rider_id: array_of_details[2].to_i,
          date: array_of_details[3].to_s,
          rating: array_of_details[4].to_i
        }
      end
    end

    def self.all
      @@trips ||= read_csv
    end

    # def self.find(id)
    #   #given trip_id, find driver instance
    #   trip_details = nil
    #   all.each do |trip|
    #     if trip[:id] == id
    #       trip_details = trip
    #     end
    #   end
    #   trip_details
    # end

    def self.find_driver_trips(driver_id)
      #given driver_id find list of all trips
      driver_trips = []
      all.each do |trip|
        if trip[:driver_id] == driver_id
          driver_trips << trip
        end
      end
      driver_trips
    end

    def self.find_rider_trips(rider_id)
      #given rider_id find list of all trips
      rider_trips = []
      all.each do |trip|
        if trip[:rider_id] == rider_id
          rider_trips << trip
        end
      end
      rider_trips
    end
  end
end
