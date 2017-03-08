require_relative 'rideshare'

module RideShare

  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    # could try to implement hash argument instead
    def initialize(id, driver_id, rider_id, date, rating)
      raise ArgumentError.new("The ID is invalid.") if id.class != Integer
      raise ArgumentError.new("The driver ID is invalid.") if driver_id.class != Integer
      raise ArgumentError.new("The rider ID is invalid.") if rider_id.class != Integer
      raise ArgumentError.new("The date is invalid.") if date.class != String
      raise InvalidRatingError.new("The rating is invalid.") if !(1..5).include?(rating)


      @id = id.to_i
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating.to_i
    end

    # could implement with hash
    def self.all
      CSV.read("support/trips.csv", headers: true).map do | line |
        RideShare::Trip.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
      end
    end

    def self.find_by_driver(driver_id)
      raise ArgumentError.new("The driver ID is invalid.") if driver_id.class != Integer
      self.all.find_all { |trip| trip.driver_id == driver_id }
    end

    def self.find_by_rider(rider_id)
      raise ArgumentError.new("The rider ID is invalid.") if rider_id.class != Integer
      self.all.find_all { |trip| trip.rider_id == rider_id }
    end

  end

end
