require 'csv'

# Rider class, subclass of RideShare
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number
    # creates new rider and take in id, name, and phone
    def initialize(rider_info={})
      @id = rider_info[:id].to_i
      @name = rider_info[:name]
      @phone_number = rider_info[:phone_number]
    end

    # class method: .all  (calls .new)
    def self.all
      @all_riders = []
      # read in CSV and create new Rider instances from each row
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/riders.csv", {:headers => true}) do |row| # file directory for rake
        @all_riders << RideShare::Rider.new(
          id: row[0],
          name: row[1],
          phone_number: row[2]
        )
      end
      return @all_riders # array of Rider instances
    end

    # class method: .find  (calls .all)
    def self.find(rider_id)
      # finds an instance of Rider by ID
      begin
        found_rider = all.select { |instance| instance.id == rider_id }
        raise MissingAccountError.new("Missing rider: Rider_#{rider_id}.") if found_rider.empty?
        raise DuplicateAccountError.new("Duplicates found: Rider_#{rider_id}.") if found_rider.length > 1
      rescue MissingAccountError => alert
        puts alert.message
      rescue DuplicateAccountError => alert
        puts alert.message
      else
        return found_rider[0] # a Rider instance
      end
    end

    # instance method: .past_trips  (calls Trip class)
    def past_trips
      RideShare::Trip.by_rider(@id)
      # returns all Trip instances for this Rider instance
    end

    # instance method: .past_drivers  (calls Trip/Driver class)
    def past_drivers
      trips = RideShare::Trip.by_rider(@id) # all trip instances of Rider
      driver_ids = trips.map { |trip| trip.driver_id }
      driver_ids.uniq.map { |id| RideShare::Driver.find(id) } # removes duplicates
      # returns all Driver instances for this Rider instance
    end
  end
end
