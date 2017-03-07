require 'csv'

module RideShare
  class Driver
    attr_reader :id_d, :name_d, :vin

    def  initialize(id_d, name_d, vin)
      raise ArgumentError.new("no valid ID") if id_d.class != Integer
      raise ArgumentError.new("name must be a string") if name_d.class != String
      raise ArgumentError.new("vin must has 17 characters") if vin.length != 17
      @id_d = id_d
      @name_d = name_d
      @vin = vin
      # @info = []
    end#end of initialize in driver class

    def self.all
      info = []
      CSV.open("support/drivers.csv", :headers => true).each do |line|
        info << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      info
    end

    def self.find_drivers_trips(id_d)
      all.each do |line|
        return line if line.id_d == id_d
      end
    end

    def drivers_rating

    end
  end#end of Driver Class

  class Rider
  end#end of Rider class

  class Trip
  end#end of Trip class
end#end of RideShare Module

# print RideShare::Driver.all
