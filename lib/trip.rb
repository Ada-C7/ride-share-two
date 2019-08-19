module RideShare
  class Trip
    include Validation
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_hash)
      @id = validate_int(trip_hash[:id], "Trip ID")
      @driver_id = validate_int(trip_hash[:driver_id], "Driver ID")
      @rider_id = validate_int(trip_hash[:rider_id], "Rider ID")
      @date = Date.parse(validate_string(trip_hash[:date], "Date"))
      @rating = validate_int_range(trip_hash[:rating], "Rating", 1, 5)
    end

    def self.all
      return CSV.read("support/trips.csv")[1..-1].map do |line|
        new( {
          id: line[0].to_i,
          driver_id: line[1].to_i,
          rider_id: line[2].to_i,
          date: line[3],
          rating: line[4].to_i
        } )
      end
    end

    def self.find_driver_trips(driver_id)
      trips = all
      return trips.select { |trip| driver_id == trip.driver_id }
    end

    def self.find_rider_trips(rider_id)
      trips = all
      return trips.select { |trip| rider_id == trip.rider_id }
    end

    def driver
      begin
        return Driver.find(driver_id)
      rescue NoDriverError => e
        puts "An error has occurred: #{e.message}"
      end
    end

    def rider
      begin
        return Rider.find(rider_id)
      rescue NoRiderError => e
        puts "An error has occurred: #{e.message}"
      end
    end
  end
end
