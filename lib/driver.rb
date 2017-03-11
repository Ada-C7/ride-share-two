module RideShare
  class Driver
    include Validation
    attr_reader :id, :name, :vin

    def initialize(driver_hash)
      @id = validate_int(driver_hash[:id], "Driver ID")
      @name = validate_string(driver_hash[:name], "Name")
      @vin = validate_string_length(driver_hash[:vin], "VIN", 17)
    end

    def self.all
      return CSV.read("support/drivers.csv")[1..-1].map do |line|
        new( {
          id: line[0].to_i,
          name: line[1],
          vin: line[2]
        } )
      end
    end

    def self.find(id)
      found_driver = all.find { |driver| driver.id == id }
      raise NoDriverError.new("Driver with that ID does not exist") if found_driver == nil
      return found_driver
    end

    def trips
      return Trip.find_driver_trips(id)
    end

    def avg_rating
      raise NoRatingError.new("This driver doesn't have any ratings yet") if trips.empty?
      trip_ratings = trips.map { |trip| trip.rating }
      average_rating = trip_ratings.reduce(:+) / trips.length.to_f
      return average_rating.round(2)
    end
  end
end
