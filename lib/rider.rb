require 'csv'

module RideShare
  class Rider
    attr_accessor :rider_id, :name, :phone_num

    def initialize(args)
      @rider_id = args[:rider_id]
      @name = args[:name]
      @phone_num = args[:phone_num]

      raise ArgumentError.new("rider id must be an integer") unless @rider_id.class == Integer
    end

    def self.all
      riders = []
      CSV.foreach("support/riders.csv", {:headers => true, header_converters: :symbol, converters: :all}) do |line|
        riders << RideShare::Rider.new(line)
      end
      return riders
    end

    def self.find(rider_id)
      all.each do |rider|
        if rider.rider_id == rider_id
          return rider
        end
      end
      raise InvalidRider.new("that rider does not exist")
    end

    def trips
      Trip.find_for_rider(@rider_id)
    end

    def drivers
      drivers = []
      trips.each do |trip|
        drivers << Trip.find_for_driver(trip.driver_id)
      end
    end

  end
end
