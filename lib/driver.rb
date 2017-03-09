# Driver
#
# Each driver should:
#
# TODO: have an ID, name and vehicle identification number

# Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number

# Given a driver object, you should be able to:
#
# TODO: retrieve the list of trip instances that only this driver has taken
# TODO: retrieve an average rating for that driver based on all trips taken

# You should be able to:
#
# TODO:retrieve all drivers from the CSV file
# TODO: find a specific driver using their numeric ID

require 'csv'

module RideShare
  class Driver
    # attr_reader :driver_id, :name, :vin
    def initialize (driver_id, name, vin)
      @driver_id = driver_id
      @name = name
      @vin = vin

    end

    def self.all
      # TODO: Clean up variable names.
      read_file = CSV.readlines('support/drivers.csv')

      drivers_array = CSV.readlines('support/drivers.csv').delete_if do |row|
        row == read_file[0]
      end

      drivers_array_2 = []
      drivers_array.each do |var|
        driver_id = var[0].to_s
        name = var[1].to_s
        phone_num = var[2].to_s
        driver = RideShare::Driver.new(driver_id, name, phone_num)

        drivers_array_2 << driver
        # return drivers_array_2
      end
    end

    def self.find
    end

    def trips
    end

    def avg_rating
    end

  end
end


# test_1 = RideShare::Driver.all
#
# puts test_1.is_a? Array
