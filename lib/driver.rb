require 'csv'
#require anything else?
require 'pry'
module RideShare

    class Driver
        attr_reader :id, :name, :vin

        def initialize (id, name, vin)
            @id = id
            @name = name
            #vin should be of a certain length and needs to be checked
            @vin = vin
        end


        def self.all
            drivers = []

            CSV.read("support/drivers.csv").each do |line|
                id = line[0].to_i
                name = line[1]
                vin = line[2]

                if id !=0
                    driver = RideShare::Driver.new(id, name, vin)
                    drivers << driver
                end
            end

            return drivers
        end

        def self.find(id)
            drivers = RideShare::Driver.all

            drivers.each do |driver|
                if driver.id == id
                    return driver
                end
            end

            raise ArgumentError.new("Invalid driver id")
        end


        def find_trips
            RideShare::Trip.find_all_drivers(@id)
        end


        def average_rating
            RideShare::Trip.calculate_average_rating(@id)

        #start a ratings counter at 0
        #loop through the array of all trips for this driver
        #at each loop add the rating to the ratings counter
        #divide total ratings by the length of the trips array

        #method returns the average rating
        end


    end
end
