module RideShare
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize
    end

    def self.all
      # reads drivers.csv file
    end

    def self.find
      # finds an instance of the drivers.csv file
    end

    def self.find_many_driver(driver_id)
    end

    def self.find_many_rider(rider_id)
    end

  end
end
