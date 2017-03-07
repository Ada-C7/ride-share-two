#require csv?
#require anything else??

module RideShare
    class Rider
        attr_reader :id, :name, :phone_number
        def intialize (id, name, phone_number)
            @id = id
            @name = name
            @phone_number = phone_number
        end


        #find_trips(id)
        #calls rider_find_all in trips
        #this will loop through the list of trips looking for matches with this id
        #and then return an array of all of the trips
        # end

        #previous_drivers(id)
        #rider_find_all to get the list of trips the rider with this id has taken
        #this method then takes that array and loops through looking for drivers
        #drivers are pushed to an array of drivers
        #somehow duplicates are then taken out of that array
        # end

        #self.all
        #reads in CSV files
        #returns an array containing all of the information in the CSV file
        # end

        #self.find(id)
        #calls self.all
        #loops through the array returned by CSV file looking for array.id == id
        #if/when there is a match, return that rider object
        # end
    end

end
