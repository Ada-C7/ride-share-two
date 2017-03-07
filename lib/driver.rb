require_relative 'trip'

class Driver

     attr_reader :id, :name, :vehicle_id

     def initialize(id, name, vehicle_id)
          @id = id
          @name = name
          @vehicle_id = vehicle_id
          #driver should have a vehicle identification number (limited to 8 characters)
     end

end
