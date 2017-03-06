module RideShare
  class Driver
    attr_accessor :id
    
    def initialize(args)
      @id = args[:id]
    end
  end
end
