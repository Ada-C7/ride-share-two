
module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vin = verified_vin(args[:vin])
    end

    def self.all
      drivers_array = []
      CSV.read("support/drivers.csv", {:headers => true}).each do |driver|
        begin
          args = {
          :id => driver[0],
          :name => driver[1],
          :vin => driver[2]
          }
          drivers_array << (Driver.new(args))
        rescue ArgumentError
          #this will only apply if csv has errors
          drivers_array << (Driver.new(driver[0], driver[1], nil))
          puts "Vin is not 17 characters"
        end
      end
      drivers_array
    end


    # def self.find(id)
    #   driver_array = self.all
    #   driver_array.each do |driver|
    #     if id == driver.id
    #       return driver
    #     end
    #   end
    #   raise ArgumentError.new "Driver #{id} does not exist"
    # end

    def self.find(id)
      driver_array = self.all
      driver_array.find { |driver| id == driver.id }
    end


    def trips
      driver_id = id
      RideShare::Trip.find_by_driver(driver_id)
      #instance method - retrieve the list of trip instances that only this driver has taken
      #RETURN ARRAY OF TRIPS
    end


    # def average_rating
    #   driver_id = id
    #   rating_array = []
    #   trips_array = RideShare::Trip.find_by_driver(driver_id)
    #   trips_array.each do |trip|
    #     rating_array << trip.rating.to_f
    #   end
    #   total  = rating_array.reduce(:+)/rating_array.length
    #   total.round(2)
    #   #instance method - retrieve an average rating for that driver based on all trips taken
    #   # call trips
    # end

    def average_rating
      driver_id = id
      rating_array = []
      trips_array = RideShare::Trip.find_by_driver(driver_id)
      trips_array.collect! { |trip| trip.rating.to_f }
      total  = trips_array.reduce(:+)/trips_array.length
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
