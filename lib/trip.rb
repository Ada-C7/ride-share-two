require_relative 'driver'
require_relative 'rider'

class Trip

     attr_reader :id, :driver_id, :rider_id, :date, :rating

     def initialize(id, rider_id, driver_id, date, rating)
          raise ArgumentError if rating.class != Integer || rating > 5 || rating < 1
          @id = id
          @driver_id = rider_id
          @rider_id = driver_id
          @date = date
          @rating = rating
     end

     def self.all(file)
          all_trips = []

          CSV.open(file).each do | line |
               @id = line[0].to_i
               @driver_id = line[1].to_i
               @rider_id = line[2].to_i
               @date = line[3]
               @rating = line[4].to_i
               trip = Trip.new(@id, @driver_id, @rider_id, @date, @rating)
               all_trips << trip
          end

          return all_trips
     end

     def self.validate_driver(driver_file, id)
          Driver.find(driver_file, id)
     end

     def self.find_trips_for_driver(driver_file, file, id)
          Trip.validate_driver(driver_file, id)

          driver_trips = []
          all_trips = Trip.all(file)

          all_trips.each do | trip |
               if trip.driver_id == id
                    driver_trips << trip
               end
          end

          return driver_trips
     end

     def self.validate_rider(rider_file, id)
          Rider.find(rider_file, id)
     end

     def self.find_trips_for_rider(rider_file, file, id)
          Trip.validate_rider(rider_file, id)

          rider_trips = []
          all_trips = Trip.all(file)

          all_trips.each do | trip |
               if trip.rider_id == id
                    rider_trips << trip
               end
          end

          return rider_trips
     end

end

#puts Trip.self
