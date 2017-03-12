module RideShare

  class Driver
  attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      raise ArgumentError.new("ID must be integer") if id.class != Integer
      raise ArgumentError.new("Name must be string") if name.class != String
      raise ArgumentError.new("Vin must be 17 character string") if vin.class != String || vin.length != 17

      @id = id
      @name = name
      @vin = vin
    end

    def trips
      return RideShare::Trip.drivers_trips(@id)
    end

    def avg_rating
      raise ArgumentError.new("No ratings.") if num_trips == 0
      return ratings_sum / num_trips.to_f
    end

    def self.all
      all_drivers = []

      CSV.foreach("support/drivers.csv", :headers => true) do | line |
        id = line[0].to_i
        name = line[1]
        vin = line[2]

        all_drivers << RideShare::Driver.new(id, name, vin)
      end

      return all_drivers
    end

    def self.find(driver_id)
      RideShare::Driver.all.each do | driver |
        return driver if driver_id == driver.id
      end

      raise ArgumentError.new("Invalid Driver ID in RideShare::Driver #find")
    end


    private

    def num_trips
      return trips.length
    end

    def ratings_sum
      sum = 0

      trips.each do | trip |
        sum += trip.rating
      end

      return sum
    end

  end

end
