require_relative 'driver'
require_relative 'rider'

class Trip

     attr_reader :id, :driver_id, :rider_id, :date, :rating

     def initialize(id, driver_id, rider_id, date, rating)
          raise ArgumentError if rating.class != Integer || rating > 5 || rating < 1
          @id = id
          @driver_id = driver_id
          @rider_id = rider_id
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

     def self.find_driver(id, file, driver_file)

          trip = find_trip(id, file)
          driver = Driver.find(driver_file, trip.driver_id)

          return driver
     end

     private

     def self.find_trip(id, file)

          all_trips = Trip.all(file)

          all_trips.each do | trip |

               if trip.id == id
                    return trip
               end
          end

          raise ArgumentError.new "Trip #{id} does not exist."

     end



end

# all_trips = Trip.all("../support/trips.csv")
#
# driver_file = "../support/driver.csv"
#
# id = 33
#
# puts all_trips.length
#
# driver_id = 1
#
#
# all_trips.each do | trip |
#
#
#      if trip.id == id
#           puts trip
#           driver_id = trip.driver_id
#      end
#
# end
#
# puts driver_id
#
# driver = all_trips.validate_driver(driver_file, driver_id)
#
# puts driver
