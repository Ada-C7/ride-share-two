#require csv??
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

#find_trips(id)
    #retrieve list of all trip instances based on the drivers id
    #do this by calling the driver_find_all in the Trips class

    #return the list of trips for this individual driver
#end


#average_rating(id)
    #call the find_trips(id) which will call the driver_find_all or just call driver find all

    #start a ratings counter at 0
    #loop through the array of all trips for this driver
    #at each loop add the rating to the ratings counter
    #divide total ratings by the length of the trips array

    #method returns the average rating
# end


#self.all
    #reads in the csv
    #stores each line in the CSV as an element in an array
# end

#self.find(id)
    #calls self.all
    #uses the array of trips from all and checks the array.id to see if it matches the id argument passed in
    #if it does, then return this instance of driver
# end

    end
end
