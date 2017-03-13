require 'csv'
require_relative 'errors'

module RideShare
  class Driver
    attr_accessor :driver_id, :name, :vin

    # initialize and raise errors if arguments are not appropriate data types
    def initialize(args)
      @driver_id = args[:driver_id]
      raise ArgumentError.new("driver id must be a positive integer") unless @driver_id.class == Integer && @driver_id > 0

      @name = args[:name]
      raise ArgumentError.new("driver name must be a string") unless @name.class == String

      @vin = args[:vin]
      raise ArgumentError.new("vehicle id must be a string") unless @vin.class == String
      raise ArgumentError.new("vehicle id must be 17 characters long") unless @vin.length == 17
    end

    # Find all Trip instances for driver
    def trips
      Trip.find_for_driver(@driver_id)
    end

    # Find the average rating for driver (rounded to one decimal point)
    def rating
      average_rating = (trips.collect {|trip| trip.rating.to_f}.sum)/trips.length
      ## Code below functions the same as the code in line 28
      ## Was unsure which design was preferred, so left both in
      # total_rating = 0.0
      # trips.each do |trip|
      #   total_rating += trip.rating
      # end
      # average_rating = total_rating/trips.length
      return average_rating.round(1)
    end

    # Read all data from driver csv file and store as an array of Driver instances
    def self.all
      drivers = []
      CSV.foreach("support/drivers.csv", {:headers => true, header_converters: :symbol, converters: :all}) do |line|
          drivers << RideShare::Driver.new(line)
      end
      return drivers
    end

    # Find a driver based on driver id
    # Raise error if that driver does not exist
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
