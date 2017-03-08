require_relative './trip'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @vin = info[:vin]
    end

    # this is highly coupled - creating a very strong dependency
    # between Driver and Trip - can we say intentially coupled?
    # also it is isolated
    def get_trips()
      RideShare::Trip.find_by_driver(@id)
    end

    # argument: trips is return of get_trips
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

    def self.all(drivers_data = nil)
      if drivers_data == nil
        data = FileData.new('./support/drivers.csv')
        drivers_data = data.read_csv_and_remove_headings
      end

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

    def self.find(driver_id)
      drivers = all
      driver = drivers.each { |info| return info if info.id == driver_id }
      nil
    end
  end
end
#
# driver_info = {
#   id: 75,
#   name: 'Cynthia',
#   vin: 'WBWSS52P9NEYLVDE9'
# }


# testing average the old school way
# trips_raw = [
#   ['1', '75', '23', '1-2-17','3'],
#   ['1', '75', '23', '1-2-17','4'],
#   ['1', '75', '23', '1-2-17','5'],
#   ['1', '75', '23', '1-2-17','3']
# ]
#
# trips = RideShare::Trip.all(trips_raw)
# driver = RideShare::Driver.new(driver_info)
# p driver.calculate_average_rating(trips)
