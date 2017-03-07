require_relative 'trip'

class Driver

     attr_reader :id, :name, :vehicle_id

     def initialize(id, name, vehicle_id)
          raise ArgumentError if vehicle_id.class != String || vehicle_id.length > 7
          @id = id
          @name = name
          @vehicle_id = vehicle_id
     end

end
