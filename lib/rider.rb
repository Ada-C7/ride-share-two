# new Rider, subclass of RideShare
module RideShare
  class Rider
    attr_reader :id, :name, :phone_number
    # create new rider and take in id, name, and phone
    def initialize(rider_info) # ={}
      @id = rider_info[:id]
      @name = rider_info[:name]
      @vin = rider_info[:phone_number]
    end
  end
end

# instance method: past_trips
# return collection of trip instances by this rider

# instance method: past_drivers
# return collection of driver instances (through the trips functionality)

# class method: all
# read in CSV file for all instances of riders
# return all instances of driver

# class method: find(id)
# return specific instance of rider (previously instantiated)
