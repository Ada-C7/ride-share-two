module RideShare

  class Driver
  attr_reader :id, :name, :vin

    # creates driver that has an ID, name, and vehicle identification number (vin)
    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin.length == 17 ? vin : "00000000000000000"
    end


    # retreives lists of all trips for specific driver
    def trips
    end


    # calculates an average rating of all trips for specific driver
    def avg_rating
    end


    # retreives all drivers from CSV
    def self.all
      all_drivers = []

      CSV.open("support/drivers.csv").each do | line |
        id = line[0].to_i
        name = line[1]
        vin = line[2]

        all_drivers << RideShare::Driver.new(id, name, vin)
      end

      return all_drivers
    end


    # finds driver using the driver's id
    def self.find(driver_id)
      all_drivers = RideShare::Driver.all

      all_drivers.each do | driver |
        if driver_id == driver.id
          return driver
        end
      end
    end

  end

end
