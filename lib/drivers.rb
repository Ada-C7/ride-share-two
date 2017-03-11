
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
        rescue InvalidVinError
          #this will only apply if csv has errors
          puts "Vin for driver #{id} is not valid"
          args = {
          :id => driver[0],
          :name => driver[1],
          :vin => nil
          }
          drivers_array << Driver.new(args)
        end
      end
      drivers_array
    end

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

    #instance method - retrieve an average rating for that driver based on all trips taken
    def average_rating
      driver_id = id
      trips_array = RideShare::Trip.find_by_driver(driver_id)
      trips_array.collect! { |trip| trip.rating.to_f }
      trips_array.reject! { |trip| trip < 1 }
      total = trips_array.reduce(:+)/trips_array.length
      total.round(2)
    end

    private

    def verified_vin(vin)
      if vin == nil || vin.length == 17
        return vin
      else
        raise InvalidVinError.new("VIN must be 17 characters")
      end
    end

  end #class

end #Module
