require_relative 'trip'

module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def self.all
    end

    def self.find
    end

    def initialize(driver)
      @id = driver[:id]
      @name = driver[:name]
      @vin = driver[:vin]
    end

    def trips
    end

    def rating
    end

  end

end
