require 'csv'
require_relative 'trip'
# require_relative 'rider'
module RideShare
  class Driver
    attr_reader :driver_id, :vin, :name
    def initialize(hash)
      validate_input(hash)
      @driver_id = hash[:driver_id]
      @vin = hash[:vin]
      @name = hash[:name]
    end

    def validate_input(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      if hash[:vin].class != String || hash[:vin].length != 17
        raise ArgumentError.new("Vin number must be string and contain 17 character only")
      end
      if (hash[:driver_id].class != Integer || hash[:driver_id] <= 0)
        raise ArgumentError.new("Driver id must be an positive integer")
      end
       if  !(hash[:name][/['. a-zA-Z]+/] == hash[:name])
        raise ArgumentError.new("Name must contain letters only")
      end
      raise ArgumentError.new("VIN must be a string") if hash[:vin].class != String
    end

    def all_driver_trips
      RideShare::Trip.all_trips_by_driver(@driver_id)
    end

    def average_rating
      total_rating = 0
      average_rating = 0
      all_driver_trips.each do |trip|
        total_rating += trip.rating
      end
      if total_rating != 0
        average_rating = (total_rating/all_driver_trips.length.to_f).round(2)
      else
        return nil
      end
    end

    def self.all  #retrieve all drivers from the CSV file
      all_drivers = []
      csv = CSV.read("support/drivers.csv", 'r')
      csv.each do |line|
      #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "driver_id"
        hash = {driver_id: line[0].to_i, name: line[1], vin: line[2]}
        all_drivers << Driver.new(hash)
      end
      all_drivers
    end

    def self.find(id)
      if id.class != Integer || id <= 0
        raise ArgumentError.new("Driver id must be non-negative integer")
      end
      result = RideShare::Driver.all.select {|driver| driver.driver_id == id}
      if result[0].nil?
        raise ArgumentError.new("Cannot find this ID in drivers")
      else
        return result[0]
      end
    end

    # total revenue of a driver for all trips:
    def total_revenue
      total = 0
      fee = 1.65
      all_driver_trips.each do |trip|
        total += trip.cost
      end
      total -= fee
      total *= 0.8
      return total
    end
  end # end of class
end # end of module
hash = {driver_id: 3, vin:"ASV48493029182345", name: "Nata ia"}
RideShare::Driver.new(hash)

dr = RideShare::Driver.all[3]
dr.total_revenue
