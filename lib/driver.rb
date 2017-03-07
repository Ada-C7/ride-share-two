require 'csv'

module Rideshare

  class Driver
    attr_reader :id, :name, :vin

    def initialize driver_hash
      @id = driver_hash[:id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
    end

    def trips driver_id

    end

    def all
      
    end

    def find driver_id
    end

    def rating driver_id
    end


  end
end
