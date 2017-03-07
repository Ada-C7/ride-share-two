#require csv?
#require other lib files?
module RideShare
    attr_reader :id, :rider_id, :driver_id, :rating
    class Trip(id, rider_id, driver_id, rating) #rating must be between 1-5 or raise an error
        @id = id
        @rider_id = rider_id
        @driver_id = driver_id
        @rating = rating
    end

    #find_driver(driver_id)
        #self.all
        #loop through array returned by self.all
        #looks for array.id == driver_id and returns driver object when a match
    # end


    #find_rider(rider_id)
        #self.all
        #loop through array returned from self.all
        #looks for array.id == rider_id and returns the driver object when a match
#  end


    #self.all
        #reads in a CSV file
        #stores each line in CSV as an element in array
        #returns array
    # end


    #driver_find_all(driver_id)
        #self.all
        #loops through the array returned by self.all and looks for driver_id matches
        #each time there is a match, the instance is pushed to an array of trips for this driver
        #return trips array
    # end


    #rider_find_all(rider_find_all)
        #self.all
        #loops through the array returned by self.all and looks for rider_id matches
        #each time there is a match, the instance is pushed to an array of trips for this rider
        #return trips array
    # end


end
