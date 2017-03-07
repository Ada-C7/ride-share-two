require_relative 'trip'

class Driver

     attr_reader :id, :name, :vin

     def initialize(id, name, vin)
          raise ArgumentError if vin.class != String || vin.length > 17
          @id = id
          @name = name
          @vin = vin
     end

end
