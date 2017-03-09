require 'csv'
require_relative 'errors'

module RideShare
  class Driver
    attr_accessor :driver_id, :name, :vin

    def initialize(args)
      @driver_id = args[:driver_id]
      raise ArgumentError.new("driver id must be an integer") unless @driver_id.class == Integer

      @name = args[:name]
      raise ArgumentError.new("driver name must be a string") unless @name.class == String

      @vin = args[:vin]
      raise ArgumentError.new("vehicle id must be a string") unless @vin.class == String
      raise ArgumentError.new("vehicle id must be 17 characters long") unless @vin.length == 17
    end


    def trips
      Trip.find_for_driver(@driver_id)
    end

    def rating
      average_rating = (trips.collect {|trip| trip.rating.to_f}.sum)/trips.length 
      # total_rating = 0.0
      # trips.each do |trip|
      #   total_rating += trip.rating
      # end
      # average_rating = total_rating/trips.length
      return average_rating.round(1)
    end


    def self.all
      drivers = []
      CSV.foreach("support/drivers.csv", {:headers => true, header_converters: :symbol, converters: :all}) do |line|
          drivers << RideShare::Driver.new(line)
      end
      return drivers
    end

    def self.find(driver_id)
      all.each do |driver|
        if driver.driver_id == driver_id
          return driver
        end
      end
      raise InvalidDriver.new("that driver does not exist")  # maybe refactor later?
    end

  end
end

# puts RideShare::Driver.all
