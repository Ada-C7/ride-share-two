# new Rider, subclass of RideShare
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number
    # create new rider and take in id, name, and phone
    def initialize(rider_info={})
      @id = rider_info[:id].to_i
      @name = rider_info[:name]
      @phone_number = rider_info[:phone_number]
    end

    def self.all
      @all_riders = []
      # read in CSV file for all instances of riders
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/riders.csv", {:headers => true}) do |row| # file directory for rake
        @all_riders << RideShare::Rider.new(
          id: row[0],
          name: row[1],
          phone_number: row[2]
        )
      end
      return @all_riders
      # return all instances of rider
    end

    def self.find(rider_id)
      found_rider = all.select { |instance| instance.id == rider_id }
      return found_rider[0]
      # return specific instance of rider (previously instantiated)
    end

    def past_trips
      RideShare::Trip.by_rider(@id)
      # return collection of trip instances by this rider
    end

    def past_drivers
      # instances of all Trips by the rider
      trips = RideShare::Trip.by_rider(@id)
      # find instances of Driver for unique ids
      driver_ids = trips.map { |trip| trip.driver_id }
      driver_ids.uniq.map { |id| RideShare::Driver.find(id) }
      # return collection of rider instances (through the trips functionality)
    end
  end
end
