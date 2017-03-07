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

     # find all trip instances for a given driver ID

     def self.all(file)
          all_trips = []

          CSV.open(file).each do | line |
               @id = line[0].to_i
               @driver_id = line[1]
               @rider_id = line[2]
               @date = line[3]
               @rating = line[4].to_i
               trip = Trip.new(@id, @driver_id, @rider_id, @date, @rating)
               all_trips << trip
          end

          return all_trips
     end


     # find all trip instances for a given rider ID
     # retrieve all trips from the CSV file
end
