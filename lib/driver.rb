module RideShare
  class Driver
    attr_accessor :id, :name, :vehicle_id

    def initialize(args)
      @id = args[:id]
      raise ArgumentError.new("driver id must be an integer") unless @id.class == Integer
      @name = args[:name]
      raise ArgumentError.new("driver name must be a string") unless @name.class == String
      @vehicle_id = args[:vehicle_id]
      raise ArgumentError.new("vehicle id must be a string") unless @vehicle_id.class == String
      raise ArgumentError.new("vehicle id must be 17 characters long") unless @vehicle_id.length == 17
    end
  end
end
