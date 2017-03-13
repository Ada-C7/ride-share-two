require 'csv'
require_relative 'missing_account_error'
require_relative 'duplicate_account_error'
require_relative 'invalid_vin_error'
require_relative 'missing_vin_error'

# new Driver, subclass of RideShare
module RideShare
  class Driver
    attr_reader :id, :name, :vin
    # create new Driver and take in id, name, vin
    def initialize(driver_info={})
      @id = driver_info[:id].to_i
      @name = driver_info[:name]
      @vin = driver_info[:vin]
      vin_verify(@vin)
    end

    def trips
    RideShare::Trip.by_driver(@id)
    # return array of Trip instances
    end

    def avg_rating
      ratings = trips.map {|trip| trip.rating }
      average = ratings.inject(:+)/ratings.length
      return average.round(2)
      # return average as rounded float
    end

    def self.all
      @all_drivers = []
      # read in CSV file to create Driver instances
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/drivers.csv", {:headers => true}) do |row| # file directory for rake
        @all_drivers << RideShare::Driver.new(
          id: row[0],
          name: row[1],
          vin: row[2]
        )
      end
      return @all_drivers # array of driver instances
    end

    def self.find(driver_id)
      begin
        found_driver = all.select { |instance| instance.id == driver_id }
        raise MissingAccountError.new("Driver ID not found.") if found_driver.empty?
        raise DuplicateAccountError.new("Duplicate accounts found.") if found_driver.length > 1
      rescue MissingAccountError => alert
        puts alert.message
      rescue DuplicateAccountError => alert
        puts alert.message
      else
        return found_driver[0] # return Driver instance
      end
    end

    private

    def vin_verify(vin)
      begin
        raise MissingVinError.new("Missing VIN, Driver_#{@id}!") if vin == nil
        if (vin.length == 17 && !vin.match(/\A[a-zA-Z0-9]*\z/).nil?) == false
          raise InvalidVinError.new("Invalid VIN, Driver_#{@id}!")
        end
      rescue MissingVinError => alert
        puts alert.message
      rescue InvalidVinError => alert
        puts alert.message
      end
    end
  end
end

# RideShare::Driver.all
# RideShare::Driver.find(1000)
RideShare::Driver.new(vin: "TTT")
