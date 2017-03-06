module RideShare
  class Driver
    attr_accessor :id, :name, :vehicle_id

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vehicle_id = args[:vehicle_id]
    end
  end
end
