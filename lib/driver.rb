require 'csv'
require_relative 'no_account_found_error'
require_relative 'duplicate_account_error'

# new Driver, subclass of RideShare
module RideShare
  class Driver
    attr_reader :id, :name, :vin
    # create new driver and take in id, name, vin
    def initialize(driver_info={})
      @id = driver_info[:id].to_i
      @name = driver_info[:name]
      unless driver_info[:vin] == nil || valid_vin?(driver_info[:vin])
        raise ArgumentError.new("vin is invalid")
      end
      @vin = driver_info[:vin]
    end

    def trips
    RideShare::Trip.by_driver(@id)
    # return collection of trip instances by this driver
    end

    def avg_rating
      ratings = trips.map {|trip| trip.rating }
      average = ratings.inject(:+)/ratings.length
      return average.round(2)
      # return rounded average rating across all trips by this driver
    end

    def self.all
      @all_drivers = []
      # read in CSV file for all instances of drivers
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/drivers.csv", {:headers => true}) do |row| # file directory for rake
        @all_drivers << RideShare::Driver.new(
          id: row[0],
          name: row[1],
          vin: row[2]
        )
      end
      return @all_drivers
      # return all instances of driver
    end

    def self.find(driver_id)
      begin
        found_driver = @all_drivers.select { |instance| instance.id == driver_id }
        raise NoAccountFoundError.new("Driver ID not found.") if found_driver.empty?
        raise DuplicateAccountError.new("Duplicate accounts found.") if found_driver.length > 1
      rescue NoAccountFoundError => alert
        puts alert.message
      rescue DuplicateAccountError => alert
        puts alert.message
      else
        return found_driver[0]
      end
    end

    private

    def valid_vin?(vin)
    vin.length == 17 && !vin.match(/\A[a-zA-Z0-9]*\z/).nil?
    end
  end
end

# RideShare::Driver.all
# RideShare::Driver.find(1000)
