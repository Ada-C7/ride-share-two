require "csv"
require_relative 'trip'
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

#this method only returns
    def list_drivers_for_rider
      drivers = []
      list_rider_trips.each do |trip|
        drivers << trip.driver_id  #tried to write call trip.trip_driver_instance,
        # but ended up in a confounding loop about unintitialized constants and harmful circular require_relatives
      end
      return drivers
      # binding.pry
    end

    # def list_drivers_for_rider
    #   drivers = list_rider_trips.map{|trip|trip.find_driver}.delete_if{|driver| driver == nil }.uniq{|driver|driver_id}
    #   # end
    #   return drivers
    #   binding.pry
    # end
      # RideShareTwo::Trip.rider_trips(@rider_id).each do
      # drivers <<
      # drivers << RideShareTwo::Trip.find_driver
      # drivers << trip.RideShareTwo::Trip.find_driver(@driver_id)#all_trips.driver
      # end
      # write the code!

      # RideShareTwo::Trip.rider_trips(@rider_id)

    # def list_drivers_for_rider
    #   drivers = []
    #   list_rider_trips.each do |trip|
    #     drivers << RideShareTwo::Trip.find_driver
    #     # drivers << trip.RideShareTwo::Trip.find_driver(@driver_id)#all_trips.driver
    #   end
    #   # write the code!
    #   return drivers
    #   # RideShareTwo::Trip.rider_trips(@rider_id)
    # end

    # def trip_driver_instance
    #   RideShareTwo::Driver.find_driver(@driver_id)
    # end


  end
end


puts RideShareTwo::Rider.find_rider(280).list_rider_trips
# puts RideShareTwo::Driver.find_driver(13).list_driver_trips
puts RideShareTwo::Rider.find_rider(280).list_drivers_for_rider
