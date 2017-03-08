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
          @average_rating = []
     end

     def recall_trips(file, trip_file)
          @trips = Trip.find_trips_for_driver(file, trip_file, @id)
          return @trips
     end

     def calculate_average_rating(file, trip_file)

          all_trips = recall_trips(file, trip_file)

          @average_rating = all_trips.inject(0) { | sum, trip | sum + trip.rating}/all_trips.length

          return @average_rating
     end

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
