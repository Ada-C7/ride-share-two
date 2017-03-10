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
    # only plus about this is it is isolated
    def get_trips()
      RideShare::Trip.find_by_driver(@id)
    end

    # should I give this method an argument of trips
    # argument: trips is return of get_trips
    def calculate_average_rating()
      trips = get_trips
      ratings = trips.map { |trip| trip.rating }
      (ratings.sum.to_f) / (ratings.length)
    end

                ###################
                ## Class methods ##
                ###################

    def self.test_for_integer(num)
      Integer(num)
    end

    # do you need to test this string? or is making sure it is included enough
    def self.test_name(name)
      raise ArgumentError.new "Name length is under 1" if name.length <= 1
      name
    end

    def self.test_for_vin(vin)
      raise ArgumentError.new("Vin must be 17 characters") unless vin.length == 17
      vin
    end

    def self.get_data
      data = FileData.new('./support/drivers.csv')
      data.read_csv_and_remove_headings
    end

    def self.all(drivers_data = nil)
      drivers_data = get_data if drivers_data.nil?
      raise ArgumentError.new("Data is empty array") if drivers_data.empty?

      drivers = drivers_data.map do |driver_info|
        raise ArgumentError.new("Driver info must have 3 parts") unless driver_info.length == 3
        driver = Hash.new
        driver[:id] = test_for_integer(driver_info[0])
        driver[:name] = test_name(driver_info[1])
        driver[:vin] = test_for_vin(driver_info[2])
        self.new(driver)
      end

      return drivers
    end

    def self.find(driver_id)
      drivers = all
      drivers.each { |driver| return driver if driver.id == driver_id }
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
#
# # testing average the old school way
# trips_raw = [
#   ['1', '175', '20', '1-2-17','3'],
#   ['2', '175', '21', '1-3-17','4'],
#   ['3', '175', '22', '1-4-17','5'],
#   ['4', '175', '23', '1-5-17','3'],
#   ['5', '175', '24', '1-6-17','3'],
#   ['6', '175', '25', '1-7-17','4']
# ]
#
# trips = RideShare::Trip.all(trips_raw)
# driver = RideShare::Driver.new(driver_info)
# p driver.calculate_average_rating(trips)
