module RideSharing
  class Driver
    
    attr_reader :id, :name, :vin
    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin
    end

  end # End of class Driver
end # End of module RideSharing
