require 'csv'
require 'bad_vin_error'

module RideShare
  class Driver
    CORP_FEE = 1.65 #gets subtracted from trip cost
    PAY_RATE = 0.80 #percent of trip cost that goes to driver

    attr_reader :id, :name, :vin

    def initialize driver_hash #order matches csv file
      validate_input driver_hash

      @id = driver_hash[:id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]

    end

    def self.all
      drivers = []
      temp_csv = CSV.read("support/drivers.csv")
      temp_csv.shift #removes first row, which is a header row (thx, google)
      temp_csv.each do |driver|
        begin
          driver_hash = Hash.new
          driver_hash[:id] = driver[0].to_i
          driver_hash[:name]= driver[1]
          driver_hash[:vin] = driver[2]
          drivers << Driver.new(driver_hash)
        rescue BadVinError
          driver_hash = Hash.new
          driver_hash[:id] = driver[0].to_i
          driver_hash[:name]= driver[1]
          driver_hash[:vin] = "0"*17
          drivers << Driver.new(driver_hash)
          puts "Invalid vin! Dummy vin {#{'0'*17}} used in\nentry #{driver} from CSV file"
        end

      end

      return drivers
      #check to make sure the entries are valid, if they are not make decisions about how to handle them
    end

    def self.find driver_id #assumes all drivers have unique ids
      all_drivers = Driver.all
      return all_drivers.find { |driver| driver_id == driver.id}
    end

    def self.add_driver driver_hash
      unless Driver.find driver_hash[:id]
        new_driver = Driver.new(driver_hash)
        CSV.open("support/drivers.csv", "a") do |line|
          line << [ driver_hash[:id], driver_hash[:name], driver_hash[:vin] ]
        end
      end
    end

    def trips
      return Trip.find_trips_by_driver @id
    end

    def rating
      driver_trips = trips
      ratings = driver_trips.map { |trip| trip.rating}
      total_rating = ratings.inject(:+).to_f
      average_rating = total_rating/driver_trips.length
      return average_rating.round(2)
      #returns average rating of those trips
    end

    def moneys
      driver_trips = trips
      return nil if driver_trips == []
      trip_costs = driver_trips.map{ |trip| trip.cost }
      total_costs = trip_costs.inject(:+)
      driver_pay = (total_costs - CORP_FEE) * PAY_RATE
      return driver_pay.round(2)
    end

    private

    def validate_input driver_hash
      raise ArgumentError.new("Driver ID must be a number") if driver_hash[:id].class != Integer
      raise ArgumentError.new("Name must be a string of characters") if driver_hash[:name].class != String
      raise BadVinError.new("invalid entry for vin; must be 17 characters and only letters or numbers. (you entered #{driver_hash[:vin]})") if driver_hash[:vin].length != 17 || driver_hash[:vin] !~ /^[0-9A-Z]+$/
    end

  end
end
