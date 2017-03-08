
module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin #ensure correct length
    end


    def self.all
      drivers_array = []
      CSV.read("support/drivers.csv", {:headers => true}).each do |driver|
        drivers_array << (Driver.new(driver[0], driver[1], driver[2]))
      end
      drivers_array
    end

    def self.find(id) #Should we rescue this??
      drivers_array = RideShare::Driver.all
      drivers_array.each do |driver|
        if id == driver.id
          return driver
        end
      end
      # raise ArgumentError.new "Driver #{id} does not exist"
    end



    def trips
      driver_id = id
      RideShare::Trip.find_by_driver(driver_id)
      #instance method - retrieve the list of trip instances that only this driver has taken
      #RETURN ARRAY OF TRIPS
    end


    def average_rating

      #instance method - retrieve an average rating for that driver based on all trips taken
      # call trips
    end








  end #class

end #Module
