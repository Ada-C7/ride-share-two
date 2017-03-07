
  class RideShare::Driver
    attr_reader :id, :name, :vin

    def initialize(driver_data)
      @id = driver_data[:id]
      @name = driver_data[:name]
      @vin = driver_data[:vin]
    end

    def trips
    end

    def rating
    end

    def self.all
      driver_array = []
      CSV.open("support/drivers.csv", 'r').each do |driver|
        new_driver = RideShare::Driver.new({
          :id => driver[0],
          :name => driver[1],
          :vin => driver[2]
          })
          driver_array << new_driver
      end
      driver_array.shift
      return driver_array
    end

    def self.find(id)
      drivers = RideShare::Driver.all
      drivers.each do |driver|
        return driver if driver.id == id
      end
    end

  end
