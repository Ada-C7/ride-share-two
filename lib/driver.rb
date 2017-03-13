require 'csv'

module RideShare
  class Driver
    attr_reader :id_d, :name_d, :vin

    def  initialize(id_d, name_d, vin)
      raise ArgumentError.new("no valid ID") if id_d.class != Integer
      raise ArgumentError.new("no valid ID") if id_d < 0
      raise ArgumentError.new("name must be a string") if name_d.class != String
      raise ArgumentError.new("vin must has 17 characters") if vin.length != 17
      @id_d = id_d
      @name_d = name_d
      @vin = vin
    end#end of initialize in driver class

    def self.all
      info = []
      CSV.open("support/drivers.csv", :headers => true).each do |line|
        info << self.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      info
    end

    def self.find_driver(id_d)
      raise ArgumentError.new('No valid ID') if id_d < 0
      raise ArgumentError.new('No valid ID') if id_d.class != Integer
      all.each do |line|
        return line if line.id_d == id_d
      end
      return "There is no driver with this ID"
    end

    def drivers_trips
      RideShare::Trip.trips_made_by_driver(@id_d)
    end

    def drivers_rating
      rates = []
      RideShare::Trip.all.each do |line|
        if line.id_d == @id_d
          rates << line.rating
          @rate = rates.sum / rates.length
        end
      end
      return @rate.round(1) if @rate != nil
      return "The driver does not have a rating"
    end

  end#end of Driver Class
end#end of the module RideShare
