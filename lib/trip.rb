require_relative 'driver'
require_relative 'rider'

class Trip

     attr_reader :id, :rider_id, :driver_id
     attr_accessor :date, :rating

     def initialize(id, rider_id, driver_id, date, rating)
          raise ArgumentError if rating.class != Integer || rating > 5 || rating < 1
          @id = id
          @rider_id = rider_id
          @driver_id = driver_id
          @date = date
          @rating = rating
     end

     #capture rider ID
     #capture driver ID
end
