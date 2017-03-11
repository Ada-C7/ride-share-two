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


        def find_trips
            RideShare::Trip.find_all_trips_riders(@id)
        end


        def previous_drivers
            RideShare::Trip.find_previous_drivers(@id)
        end

    end
end
