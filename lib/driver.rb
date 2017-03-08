module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @vin = info[:vin]
    end

    def get_trips(trip_data)
      RideShare::Trip.find_by_driver(@id, trip_data)
    end

    def calculate_average_rating(trips)
      ratings = trips.map { |trip| trip.rating }
      average = ratings.sum / ratings.length.to_f
    end
                ###################
                ## Class methods ##
                ###################
    def self.test_for_integer(num)
      Integer(num)
    end

    # do you need to test this string? or is making sure it is included enough
    def self.test_for_string(name)
      name
    end

    def self.test_for_vin(vin)
      raise ArgumentError.new("vin must be 17 characters") unless vin.length == 17
      vin
    end

    def self.all(drivers_data)
      raise ArgumentError.new("data is empty array") if drivers_data.empty?
      drivers = drivers_data.map do |driver_info|
        raise ArgumentError.new("driver info must have 3 parts") unless driver_info.length == 3
        driver = Hash.new
        driver[:id] = test_for_integer(driver_info[0])
        driver[:name] = test_for_string(driver_info[1])
        driver[:vin] = test_for_vin(driver_info[2])
        self.new(driver)
      end
      return drivers
    end

    # return nil if the account does not exist
    # this should also only return one account
    def self.find(driver_id, drivers_data)
      drivers = all(drivers_data)
      driver = drivers.each { |info| return info if info.id == driver_id }
      nil
    end
  end
end
