require 'csv'
require_relative 'trip'

class Driver

     attr_reader :id, :name, :vin, :trips, :average_rating

     def initialize(id, name, vin)
          raise ArgumentError if vin.class != String || vin.length > 17
          @id = id
          @name = name
          @vin = vin
          @trips = []
          #@average_rating = calculate_average_rating
     end

     def recall_trips(file, trip_file)
          @trips = Trip.find_trips_for_driver(file, trip_file, @id)
          return @trips
     end

     # #retrieve an average rating for that driver based on all trips taken
     # def calculate_average_rating(@id)
     #      #TODO Build block after trip.rb has been completed.
     #      all_trips = recall_trips(@id)
     #      @average_rating = all_trips.rating.map { | sum, rating | sum + rating }/all_trips.length
     #      return @average_rating
     # end

     def self.all(file)
          all_drivers = []

          CSV.open(file).each do | line |
               @id = line[0].to_i
               @name = line[1]
               @vin = line[2]
               driver = Driver.new(@id, @name, @vin)
               all_drivers << driver
          end

          return all_drivers
     end

     def self.find(file, id)

          Driver.all(file).each do | driver |

               if driver.id == id
                    return driver
               end

          end

          raise ArgumentError.new "Driver #{id} does not exist."

     end
end

# file = "../support/drivers.csv"
# trip_file = "../support/trips.csv"
#
# id = 7
# one_driver = Driver.find(file, id)
#
# # puts one_driver
# # puts one_driver.class
# # puts one_driver.inspect
#
#
# one_driver_trips = one_driver.recall_trips(file, trip_file)
#
# puts one_driver_trips
# puts one_driver_trips.class
# puts one_driver_trips.inspect
# puts one_driver_trips.length
