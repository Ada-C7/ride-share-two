require 'csv'

module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone_num

    def initialize(rider_hash)
      @rider_id = rider_hash[:rider_id]
      @name = rider_hash[:name]
      @phone_num = rider_hash[:phone_num]
    end

    def self.all
      riders = []

      CSV.read("support/riders.csv", {:headers => true, :header_converters => :symbol, :converters => :all}).each do |line|
        riders << RideShare::Rider.new(line)
      end

      return riders
    end

    def self.find(rider_id)
      save_rider = nil

      find_riders = RideShare::Rider.all
      find_riders.each do |rider|
        if rider.rider_id == rider_id
          save_rider = rider
        end
      end

      raise ArgumentError.new "Warning: Rider #{rider_id} does not exist." if save_rider == nil

      save_rider
    end

    def trip
      # gets the list of trip instances for this rider
      RideShare::Trip.find_many_riders(@rider_id)
    end

    def drivers

      # array of drivers for trips that rider has taken
      drivers_ids_for_rider_trips = trip.map { |trips| trips.driver_id }

      #find driver info for each trip
      driver_info = drivers_ids_for_rider_trips.map do |driver_ids|
        RideShare::Trip.find_many_drivers(driver_ids)
      end
      # no repeat drivers
      driver_info.uniq
    end

  end
end

# puts "#{RideShare::Rider.all}"
