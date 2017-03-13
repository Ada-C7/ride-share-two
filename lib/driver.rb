require 'csv'
require_relative 'missing_account_error'
require_relative 'duplicate_account_error'
require_relative 'invalid_vin_error'
require_relative 'missing_vin_error'

# Driver class, subclass of RideShare
module RideShare
  class Driver
    attr_reader :id, :name, :vin
    # creates new Driver and take in id, name, vin
    def initialize(driver_info={})
      @id = driver_info[:id].to_i
      @name = driver_info[:name]
      @vin = driver_info[:vin]
      vin_verify(@vin)
    end

    # class method: all  (calls .new)
    def self.all
      @all_drivers = []
      # read in CSV and create new Driver instances from each row
      CSV.foreach("/Users/tamikulon/ada/classwork/week5/ride-share-two/support/drivers.csv", {:headers => true}) do |row| # file directory for rake
        @all_drivers << RideShare::Driver.new(
          id: row[0],
          name: row[1],
          vin: row[2]
        )
      end
      return @all_drivers # array of Driver instances
    end

    # instance method: .trips  (calls Trip class)
    def trips
      RideShare::Trip.by_driver(@id)
      # returns all Trip instances for this Driver instance
    end

    # instance method: avg_rating  (calls .trips)
    def avg_rating
      # average rating of all trips for this Driver instance
      ratings = trips.map {|trip| trip.rating.to_f } # calls trips method above
      average = ratings.inject(:+)/ratings.length
      return average.round(2) # a rounded float
    end

    # class method: .find  (calls .all & custom exceptions)
    def self.find(driver_id)
      # finds an instance of Driver by ID (calls .all)
      begin
        found_driver = all.select { |instance| instance.id == driver_id }
        raise MissingAccountError.new("Missing Driver: Driver_#{driver_id}.") if found_driver.empty?
        raise DuplicateAccountError.new("Duplicates found: Driver_#{driver_id}.") if found_driver.length > 1
      rescue MissingAccountError => alert
        puts alert.message
      rescue DuplicateAccountError => alert
        puts alert.message
      else
        return found_driver[0] # a Driver instance
      end
    end

    private

    # instance method: vin_verify  (calls custom exceptions)
    def vin_verify(vin)
      # exceptions if vin is not 17-char. or alphanumeric
      begin
        raise MissingVinError.new("Missing VIN: Driver_#{@id}.") if vin == nil
        if (vin.length == 17 && !vin.match(/\A[a-zA-Z0-9]*\z/).nil?) == false
          raise InvalidVinError.new("Invalid VIN: Driver_#{@id}.")
        end
      rescue MissingVinError => alert
        puts alert.message
      rescue InvalidVinError => alert
        puts alert.message
      end
    end
  end
end
