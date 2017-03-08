require 'csv'
require 'pry'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    # vin cannot be longer or shorter than 17 characters
    def initialize(driver_hash)
      @id = driver_hash[:id]
      @name = driver_hash[:name]

      @vin = driver_hash[:vin]
      # if @vin.length == 17
      #   @vin = driver_hash[:vin]
      # else  # Cannot be < or > 17
      #   raise ArgumentError.new "The driver instance you chose does not have a valid vin number."
      # end

    end

    def trips


      # returns list of driver trips that only that driver has been on
      # returns average rating for the driver based on all the trips they have been on


    end

    def self.all
      drivers_array = []
      # reads drivers.csv file
      CSV.read("support/drivers.csv").each do |driver_row|
        drivers = RideShare::Driver.new(
        id: driver_row[0].to_i,
        name: driver_row[1],
        vin: driver_row[2]
        )
        drivers_array << drivers
      end
      #binding.pry
      drivers_array

    end

    def self.find(id)
      save_driver = nil

      find_drivers = RideShare::Driver.all
      find_drivers.each do |driver|
        if driver.id == id
          save_driver = driver
        end
      end

      raise ArgumentError.new "Warning: Driver #{id} does not exist." if save_driver == nil

      return save_driver

    end
  end
end

# find_id = RideShare::Driver.all
# puts "#{find_id}"
