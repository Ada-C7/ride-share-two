require "csv"
require_relative 'trip'

module RideShareTwo
  class Rider

    attr_reader :rider_id, :name, :phone_num

    def initialize(rider_id, name, phone_num)
      @rider_id = rider_id
      @name = name
      @phone_num = phone_num
    end

    def self.all_riders
      all_riders = []
      CSV.open("support/riders.csv",{:headers => true}).each do |array|
        all_riders << self.new(array[0].to_i, array[1], array[2].to_s)
      end
      return all_riders
    end



    def self.find_rider(rider_id)
      result = self.all_riders.select { |a| a.rider_id == rider_id }
      return result.first
    end

#write tests?
    def list_rider_trips
      RideShareTwo::Trip.rider_trips(@rider_id)
    end
    #returns array of class trip?
    #test array contains trip objects?

    def list_drivers_for_rider
      drivers = []
      # write the code!
      return drivers
      # RideShareTwo::Trip.rider_trips(@rider_id)
    end

  end

end


puts RideShareTwo::Rider.find_rider(13).list_rider_trips
# puts RideShareTwo::Driver.find_driver(13).list_driver_trips
