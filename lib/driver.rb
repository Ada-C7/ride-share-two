require 'csv'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      @id = id.to_i
      @name = name
      raise InvalidVinError.new("Vin must be 17 characters") if vin.to_s.length != 17
      @vin = vin
    end

    def self.all
      driver_array = []
      CSV.open('support/drivers.csv', 'r', :headers => true).each do |line|
        id = line["driver_id"].to_i
        name = line["name"].to_s
        vin = line["vin"].to_s
        driver_array << self.new(id, name, vin)
      end
      return driver_array
    end

    def self.find(id)
      Driver.all.each do |file|
        if file.id == id
          return file
        end
      end
      raise InvalidFileError.new("This account does not exist")
    end

    #create method that uses method from trip object to retrieve list of trips
    def get_trips #from trip object
      trips = RideShare::Trip.by_driver(@id)
      return trips
    end

    #create method that uses internal trips list to calculate average rating of driver
    def avg_rating
      ratings = get_trips.map(&:rating)
      #Cool feature with #map that my tutor showed me :)
      ratings.sum / ratings.size.to_f
    end
    
  end
end
