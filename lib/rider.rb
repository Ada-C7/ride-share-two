require 'csv'
module RideShare
  class Rider
    attr_reader :id, :name, :phone

    def initialize rider_hash
      validate_input rider_hash
      @id = rider_hash[:id]
      @name = rider_hash[:name]
      @phone = rider_hash[:phone]
    end

    def validate_input rider_hash
      raise ArgumentError.new("Rider ID needs to be an integer; entry is #{rider_hash[:id]}") if rider_hash[:id].class != Integer

      raise ArgumentError.new("Name needs to be a String; entry is #{rider_hash[:name]}") if rider_hash[:name].class != String

      raise ArgumentError.new("Phone number needs to be a String; entry is #{rider_hash[:phone]}") if rider_hash[:phone].class != String

    end

    def self.all
      riders = []
      temp_csv = CSV.read("support/riders.csv")
      temp_csv.shift #removes first row, which is a header row (thx, google)
      temp_csv.each do |rider|
          rider_hash = Hash.new
          rider_hash[:id] = rider[0].to_i
          rider_hash[:name] = rider[1]
          rider_hash[:phone] = rider[2]
          riders << Rider.new(rider_hash)
      end
      return riders
    end

    def self.find rider_id
      all_riders = Rider.all
      return all_riders.find { |rider| rider.id == rider_id }
    end
    #will return nil if rider is not found


    def trips
      return Trip.find_trips_by_rider @id
    end

    def drivers
      all_trips = trips
      driver_ids = all_trips.map { |trip| trip.driver_id }
      # unique_driver_ids = driver_ids.uniq
      unique_driver_ids = driver_ids.uniq
      return unique_driver_ids.map { |id| Driver.find(id) }


      #look through trips and for each trip instance, use the driver_id associated with the trip (trip.driver_id) to call Driver.find(driver_id)
      #store those Driver class instances in an array that gets returned
    end

  end
end
