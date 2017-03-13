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
      # read in CSV file to create Rider instances
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/riders.csv", {:headers => true}) do |row| # file directory for rake
        @all_riders << RideShare::Rider.new(
          id: row[0],
          name: row[1],
          phone_number: row[2]
        )
      end
      return @all_riders # array of Rider instances
    end

    def self.find(rider_id)
      found_rider = all.select { |instance| instance.id == rider_id }
      return found_rider[0] # single instance of rider
    end

    def past_trips
      RideShare::Trip.by_rider(@id)
      # returns array of Trip instances
    end

    def past_drivers
      trips = RideShare::Trip.by_rider(@id) # Trip instances of Rider
      driver_ids = trips.map { |trip| trip.driver_id }
      # find instances of Driver for unique ids
      driver_ids.uniq.map { |id| RideShare::Driver.find(id) }
      # returns array of Driver instances
    end
  end
end
