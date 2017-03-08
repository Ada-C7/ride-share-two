require 'csv'
# csv: CSV.foreach("../support/trips.csv", {:headers => true}) do |row|

module RideShare
  class Driver
    attr_accessor :driver_id, :name, :vin

    def initialize(driver_id, name, vin)
      raise ArgumentError.new ("Vin must be 17 characters") if vin.length != 17
      @driver_id = driver_id
      @name = name
      @vin = vin
    end

    def driver_trip_instances
      driver_trips = RideShare::Trip.driver_trip_instances(@driver_id)
      return driver_trips
    end

    retrieve an average rating for that driver based on all trips taken

    # def average_rating
    #   #   #use find driver here
    #   #   #use driver trip instances here
    #   # average rating over trip instances
    # end


    def self.all_driver_info
      all_drivers_array = []
      CSV.read('support/drivers.csv').each do |object|
        driver_id = object[0].to_i
        name = object[1].to_s
        vin = object[2].to_s
        a_driver = RideShare::Driver.new(driver_id, name, vin)
        all_drivers_array << a_driver
      end
      return all_drivers_array
    end

    def self.find_driver(driver_id)
      drivers = RideShare::Driver.all_driver_info
      drivers.each do |object|
        if object.driver_id == driver_id
          return object
        end
      end
      raise ArgumentError.new("Driver #{driver_id} does not exist")
    end


  end

end






#   # driver_id,  name,   vin
#   # 1,Bernardo Prosacco,WBWSS52P9NEYLVDE9
#   # 2,Emory Rosenbaum,1B9WEX2R92R12900E
#   # 3,Daryl Nitzsche,SAL6P2M2XNHC5Y656
#   # 4,Jeromy O'Keefe DVM,L1CKRVH55W8S6S9T1
#   # 5,Verla Marquardt,TAMLE35L3MAYRV1JD
