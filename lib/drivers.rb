
module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = verified_vin(vin)
    end

    def self.all
      drivers_array = []
      CSV.read("support/drivers.csv", {:headers => true}).each do |driver|
        begin
          drivers_array << (Driver.new(driver[0], driver[1], driver[2]))
        rescue ArgumentError
          drivers_array << (Driver.new(driver[0], driver[1], nil))
          puts "Vin is not 17 characters"
        end
      end
      drivers_array
    end


    def self.find(id)
      driver_array = self.all
      driver_array.each do |driver|
        if id == driver.id
          return driver
        end
      end
      raise ArgumentError.new "Driver #{id} does not exist"
    end



    def trips
      driver_id = id
      RideShare::Trip.find_by_driver(driver_id)
      #instance method - retrieve the list of trip instances that only this driver has taken
      #RETURN ARRAY OF TRIPS
    end


    def average_rating
      driver_id = id
      rating_array = []
      trips_array = RideShare::Trip.find_by_driver(driver_id)
      trips_array.each do |trip|
        rating_array << trip.rating.to_f
      end
      total  = rating_array.reduce(:+)/rating_array.length
      total.round(2)
      #instance method - retrieve an average rating for that driver based on all trips taken
      # call trips
    end
    #private

    def verified_vin(vin)
      if vin == nil || vin.length == 17
        return vin
      else
        raise ArgumentError.new("VIN must be 17 characters")
      end
    end


  end #class

end #Module
