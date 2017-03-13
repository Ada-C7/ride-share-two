require "csv"
require_relative 'trip'
require_relative 'driver'
# require "pry"

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
        all_riders << self.new(array[0].to_i, array[1], array[2])
      end
      return all_riders
    end


    def self.find_rider(rider_id)
      result = self.all_riders.select { |a| a.rider_id == rider_id }
      return result.first
    end

    def list_rider_trips
      RideShareTwo::Trip.rider_trips(@rider_id)
    end

# this method returns driver ids (not driver instances)
    def list_drivers_for_rider
      drivers = []
      list_rider_trips.each do |trip|
        # unless drivers. == (trip.driver_id)
          drivers << trip.trip_driver_instance

          # binding.pry
        # end
        #tried to write call trip.trip_driver_instance,
        # but ended up in a confounding loop about unintitialized constants and harmful circular require_relatives
      end
      return drivers.uniq { |driver| driver.driver_id }
    end

    # # this method returns driver ids (not driver instances)
    #     def list_drivers_for_rider
    #       drivers = []
    #       list_rider_trips.each do |trip|
    #         unless drivers.include?(trip.driver_id)
    #           drivers << trip.driver_id
    #           # binding.pry
    #         end
    #         #tried to write call trip.trip_driver_instance,
    #         # but ended up in a confounding loop about unintitialized constants and harmful circular require_relatives
    #       end
    #       return drivers
    #     end

  end
end


puts RideShareTwo::Rider.find_rider(250).list_rider_trips
# puts RideShareTwo::Driver.find_driver(13).list_driver_trips
puts RideShareTwo::Rider.find_rider(250).list_drivers_for_rider
