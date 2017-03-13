require 'csv'

module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone_num

    def initialize(args)
      @rider_id = args[:rider_id]
      @name = args[:name]
      @phone_num = args[:phone_num]

      # Verify that rider id is valid
      raise ArgumentError.new("rider id must be a positive integer") unless @rider_id.class == Integer && @rider_id > 0
    end

    # Read all values from the rider csv file
    # Store each line as an array of Rider instances
    def self.all
      riders = []
      CSV.foreach("support/riders.csv", {:headers => true, header_converters: :symbol, converters: :all}) do |line|
        riders << RideShare::Rider.new(line)
      end
      return riders
    end

    # Find a rider based on rider id
    # Raise error if that rider does not exist
    def self.find(rider_id)
      all.each do |rider|
        if rider.rider_id == rider_id
          return rider
        end
      end
      raise InvalidRider.new("that rider does not exist")
    end

    # Find all trips for a particular rider
    def trips
      Trip.find_for_rider(@rider_id)
    end

    # Find all drivers for a particular rider
    def drivers
      drivers = []
      trips.each do |trip|
        drivers << trip.driver
      end
      return drivers
    end

  end
end
