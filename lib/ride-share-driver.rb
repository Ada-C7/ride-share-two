require 'csv'

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin

    end

    def self.all
      all_drivers = []

      csv_data = CSV.read("support/drivers.csv")
      csv_data.shift

      csv_data.each do |line|
        all_drivers << Driver.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      return all_drivers
    end

    def self.find(id) # finds a specific driver using their numeric ID
      drivers = Driver.all
      return drivers.find {|driver| driver.id == id }
    end

    def self.find_trips(id)
      trips = Trips.all # csv of all trips

      driver_trips = []

      trips.each do |trip| # grab all elements that have driver_id of 1
        if trip.driver_id == id
          driver_trips << trip
        end
      end
      return driver_trips
    end

    def self.get_rating(id)
      find_trips

      driver_ratings = []

      driver_trips.each do |rating|
        driver_ratings << rating
      end

      avg_rating = []

      (avg_rating.inject{ |sum, n| sum + n }.to_f / avg_rating.size).round(2)

      return avg_rating
    end


    def to_s
      "id: #{ @id }, name: #{ @name }, VIN: #{ @vin }"
    end
  end
