require 'csv'
require_relative 'trip'
require_relative 'driver'

class Rider

     attr_reader :id, :name, :phone, :trips, :drivers

     def initialize(id, name, phone)
          @id = id
          @name = name
          @phone = phone
          @trips = []
          @drivers = []
     end

     def recall_trips(file, trip_file)
          @trips = Trip.find_trips_for_rider(file, trip_file, @id)
          return @trips
     end

     def recall_drivers(file, trip_file, driver_file)
               driver_ids = recall_trips(file, trip_file).map { | trip | trip.driver_id }
               @drivers = driver_ids.map { | driver_id | Driver.find(driver_file, driver_id)}
          return @drivers
     end

     def self.all(file)
          all_riders = []

          CSV.open(file).each do | line |
               @id = line[0].to_i
               @name = line[1]
               @phone = line[2]
               rider = Rider.new(@id, @name, @phone)
               all_riders << rider
          end

          return all_riders
     end

     def self.find(file, id)

          Rider.all(file).each do | rider |

               if rider.id == id
                    return rider
               end

          end

          raise ArgumentError.new "Rider #{id} does not exist."

     end
end
