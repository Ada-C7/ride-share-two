require 'csv'
#Create Rideshare module
module Rideshare
#Create Driver class
  class Driver
    attr_reader :id, :name, :license_num, :vin
#an ID, name, license number, vehicle identification number should be initialized\
    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @license_num = ""
      @vin = args[:vin]
      #(vehicle id # should be a specific length to ensure it's a valid vehicle)
      raise ArgumentError.new("Not a valid ID number") if @id.class != Integer
      raise ArgumentError.new("Not a valid vin number") if @vin.length != 17
    end

#self.method1 : retrive all drivers from the CSV file
    def self.all
      csv = []
      CSV.read("./support/drivers.csv").drop(1).each do |driver|
        csv.push({id: driver[0].to_i, name: driver[1], vin: driver[2]})
      end
      return csv
    end
    
#self.method2 : find a specific driver using their numeric ID
    def self.find(id_num)
      raise ArgumentError.new("Not a valid ID number") if id_num.class != Integer
      result  = all.find {|driver| driver[:id] == id_num}
      result ||= "No match"
    end

#instance_method1 : retrieve the list of trip instances that only this drver has taken
    def all_trips
      Rideshare::Trip.find_trip_by_driver(@id)
    end

#instance_method2 : retrieve an average rating for that driver based on all trips taken
    def average_rating
      return "Average rating doesn't exit for this driver" if all_trips.class == String
      total = all_trips.map { |h| h[:rating] }.sum
      average = total/all_trips.length.to_f
      return average.round(2)
    end

  end
end

# puts Rideshare::Driver.all.last
# driver = Rideshare::Driver.new(id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9")
# print driver.all_trips

# puts Rideshare::Trip.find_trip_by_driver(1)
