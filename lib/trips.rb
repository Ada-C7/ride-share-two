#require csv?
#require other lib files?
module RideShare
    class Trips
        attr_reader :id, :rider_id, :driver_id, :date, :rating
        def initialize(id, rider_id, driver_id, date, rating) #rating must be between 1-5 or raise an error
            @id = id.to_i
            @rider_id = rider_id.to_i
            @driver_id = driver_id.to_i
            @date = date
            @rating = rating.to_i
            raise ArgumentError.new("Rating must be between 1 and 5") if rating < 1 || rating > 5
        end

        def self.all
            trips = []

            CSV.open("support/trips.csv").each do |line|

                id = line[0].to_i
                driver_id = line[1].to_i
                rider_id = line[2].to_i
                date = line[3]
                rating = line[4].to_i

                if id !=0
                    trip = RideShare::Trips.new(id, driver_id, rider_id, date, rating)
                    trips << trip
                end
            end
            return trips
        end

    end

end


# def find_driver(driver_id)
# RideShare::Rideself.all
#loop through array returned by self.all
#looks for array.id == driver_id and returns driver object when a match
# end


#def find_rider(rider_id)
#self.all
#loop through array returned from self.all
#looks for array.id == rider_id and returns the driver object when a match
#  end





#def driver_find_all(driver_id)
#self.all
#loops through the array returned by self.all and looks for driver_id matches
#each time there is a match, the instance is pushed to an array of trips for this driver
#return trips array
# end


#def rider_find_all(rider_find_all)
#self.all
#loops through the array returned by self.all and looks for rider_id matches
#each time there is a match, the instance is pushed to an array of trips for this rider
#return trips array
# end
