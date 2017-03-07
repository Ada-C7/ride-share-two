# new Rider, subclass of RideShare
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number
    # create new rider and take in id, name, and phone
    def initialize(rider_info) # ={}
      @id = rider_info[:id]
      @name = rider_info[:name]
      @phone_number = rider_info[:phone_number]
    end
    # instance method: past_trips
    # return collection of trip instances by this rider

    # instance method: past_riders
    # return collection of rider instances (through the trips functionality)

    # class method: all
    def self.all
      @all_riders = []
      # read in CSV file for all instances of riders
      CSV.foreach("support/riders.csv", {:headers => true}) do |row| # file directory for rake
        @all_riders << RideShare::Rider.new({
          id: row[0],
          name: row[1],
          phone_number: row[2]
        })
      end
      return @all_riders
      # return all instances of rier
    end

    # class method: find(id)
    def self.find(rider_id)
      # return specific instance of rider (previously instantiated)
      found_rider = @all_riders.select { |instance| instance.id == rider_id }
      return found_rider[0]
    end
  end
end
