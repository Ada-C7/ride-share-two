require 'csv'
require 'pry'
#require anything else??

module RideShare
    class Rider
        attr_reader :id, :name, :phone_number

        def initialize(id, name, phone_number)
            @id = id.to_i
            @name = name
            @phone_number = phone_number
        end

        def self.all
            riders = []

        CSV.open("support/riders.csv").each do |line|
            id = line[0].to_i
            name = line[1]
            phone_number = line[2]

            if id !=0
                rider = RideShare::Rider.new(id, name, phone_number)
                riders << rider
            end
        end
            return riders
        end

        def self.find(id)
            riders = RideShare::Rider.all

            riders.each do |rider|
                if rider.id == id
                    return rider
                end
                end
            raise ArgumentError.new("Invalid rider")

        end





    end
end


# find_trips(id)
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



#self.find(id)
#calls self.all
#loops through the array returned by CSV file looking for array.id == id
#if/when there is a match, return that rider object
# end
