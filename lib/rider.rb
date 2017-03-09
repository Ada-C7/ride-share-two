require_relative 'rideshare'

module RideShare

  class Rider

    attr_reader :id, :name, :phone

    def initialize(id, name, phone)
      raise ArgumentError.new("The ID is invalid.") if id.class != Integer
      raise ArgumentError.new("The name is invalid.") if name.class != String
      raise ArgumentError.new("The phone number is invalid.") if phone.class != String

      @id = id
      @name = name
      @phone = phone
    end

    def self.all
      CSV.read("support/riders.csv", headers: true).map do | line |
        RideShare::Rider.new(line[0].to_i, line[1], line[2])
      end
    end

    def self.find(rider_id)
      raise ArgumentError.new("The driver ID is invalid.") if rider_id.class != Integer
      self.all.find { |rider| rider.id == rider_id }
    end

    def trips
      RideShare::Trip.find_by_rider(@id)
    end

    def drivers
      rider_driver_ids = trips.map { |trip| trip.driver_id }
      rider_drivers = rider_driver_ids.map do |driver_id|
        RideShare::Trip.find_by_driver(driver_id)
      end
      rider_drivers.uniq
    end

  end

end
