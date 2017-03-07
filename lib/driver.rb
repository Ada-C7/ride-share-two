module RideShare
  class Driver
    attr_accessor :id, :name, :vin
    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin
    end
  end
end
