require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    # vin cannot be longer or shorter than 17 characters
    def initialize(driver_hash)
      @id = driver_hash[:id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]    # Cannot be < or > 17
    end

    def trips
      # retruns list of driver trips
    end

    def self.all
      drivers_array = []

      #this should disguard the headers for csv files
      CSV.foreach('support/drivers.csv', {:headers => true, :header_converters=> :symbol}) do |row|
        # reads drivers.csv file
        CSV.read("support/drivers.csv").each do |driver_info|
          create_new_drivers = RideShare::Driver.new(driver_info[0].to_i, driver_info[1], driver_info[2])
          drivers_array << create_new_drivers
        end
      end

      drivers_array

    end

    def self.find
      # finds an instance of the drivers.csv file
      save_driver = nil

      find_drivers = RideShare::Driver.all
      find_drivers.each do |driver|
        if driver.driver_id == driver_id
          save_driver = driver
        end
      end
    end
  end
end
