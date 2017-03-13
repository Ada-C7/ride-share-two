require 'csv'

module RideShare
  class Rider
    attr_reader :id_r, :name_r, :phone_number

    def  initialize(id_r, name_r, phone_number)
      raise ArgumentError.new("no valid ID") if id_r.class != Integer
      raise ArgumentError.new("no valid ID") if id_r < 0
      raise ArgumentError.new("name must be a string") if name_r.class != String
      if phone_number.class != String
        raise ArgumentError.new("phone_number must be a string")
      end
      @id_r = id_r
      @name_r = name_r
      @phone_number = phone_number
    end#end of initialize in rider class

    def self.all
      info = []
      CSV.open("support/riders.csv", :headers => true).each do |line|
        info << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      info
    end

    def self.find_rider(id_r)
      raise ArgumentError.new('No valid ID') if id_r < 0
      raise ArgumentError.new('No valid ID') if id_r.class != Integer
      all.each do |line|
        return line if line.id_r == id_r
      end
      return "There is no rider with this ID"
    end

    def riders_trips
      RideShare::Trip.trips_taken_by_rider(@id_r)
    end

    def rider_drivers
      rider_drivers = []
      riders_trips.each do |trip|
        rider_drivers << RideShare::Driver.find_driver(trip.id_d)
      end
      rider_drivers
    end
  end#end of Rider class
end#end of the module RideShare
