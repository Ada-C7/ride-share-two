require 'csv'
module RideShare
  class Rider
    attr_reader :id, :name, :phone

    def initialize rider_id, name, phone_num
      @id = rider_id
      @name = name
      @phone = phone_num
    end

    def self.all
      riders = []
      temp_csv = CSV.read("/Users/sai/Documents/ada/projects/ride-share-two/support/riders.csv")
      temp_csv.shift #removes first row, which is a header row (thx, google)
      temp_csv.each do |rider|
        riders << Rider.new(rider[0].to_i, rider[1], rider[2])
      end

      return riders
      #check to make sure that phone numbers are of valid format/length?
    end

    def self.find rider_id
      all_riders = Rider.all
      return all_riders.find { |rider| rider.id == rider_id }
    end
    #will return nil if rider is not found


    def trips
      #call Trip.find_trips_by_rider
      #returns array of trip instances that this rider has taken
    end

    def drivers
      #call trips
      #look through trips and for each trip instance, use the driver_id associated with the trip (trip.driver_id) to call Driver.find(driver_id)
      #store those Driver class instances in an array that gets returned
    end

  end
end
