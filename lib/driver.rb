require 'csv'

module RideShare
  class Driver
    attr_reader :name, :id, :vin

    def initialize(args)


      @name = args[:name]
      @id = args[:id]
      @vin = args[:vin]
    end
  end
end
