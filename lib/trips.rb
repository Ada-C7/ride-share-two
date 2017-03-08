#require csv?
#require other lib files?
module RideShare
    class Trip
        attr_reader :id, :rider_id, :driver_id, :date, :rating
        def initialize(id, driver_id, rider_id, date, rating) #rating must be between 1-5 or raise an error
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
                    trip = RideShare::Trip.new(id, driver_id, rider_id, date, rating)
                    trips << trip
                end
            end
            return trips
        end


        def find_driver
            RideShare::Driver.find(@driver_id)
        end

        def find_rider
            RideShare::Rider.find(@rider_id)

        end

        def self.find_all_drivers(driver_id)
            all_trips = RideShare::Trip.all

            rider_trips = []

            all_trips.each do |trip|
                if trip.driver_id == driver_id
                    rider_trips << trip
                end
            end
            return rider_trips
        end

        def self.calculate_average_rating(id)
            all_trips = RideShare::Trip.all
            ratings = []
            all_trips.each do |trip|
                if trip.driver_id == id
                    ratings << trip.rating.to_f
                end
            end

            average = ratings.reduce(:+)/ratings.length
            return average
        end


        def self.find_all_trips_riders(id)
            all_trips = RideShare::Trip.all
            trips = []

            all_trips.each do |trip|
                if trip.rider_id == id
                    trips << trip
                end
            end

            return trips
        end

        def self.find_previous_drivers(id)
            all_trips = RideShare::Trip.all

            previous_drivers_id = []
            previous_drivers_instances = []

            all_trips.each do |trip|
                if trip.rider_id == id
                    previous_drivers_id << trip.driver_id
                end
            end

            previous_drivers_id.each do |driver_id|
                driver_instance = RideShare::Driver.find(driver_id)
                previous_drivers_instances << driver_instance
            end
            return previous_drivers_instances
        end
    end
end


    
