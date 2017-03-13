# require 'csv'
# require_relative 'file'
# require_relative 'trip'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @vin = info[:vin]
    end

# dont need to worry about calling these methods on a driver that doesn't exsits
# because you have to call this method on a driver instance
# IE you can't call an method on a object that doesn't exists
    def get_trips()
      RideShare::Trip.find_by_driver(@id)
    end

    def calculate_average_rating()
      trips = get_trips
      return nil if trips.nil?
      ratings = trips.map { |trip| trip.rating }
      (ratings.sum.to_f) / (ratings.length)
    end

                          ###################
                          ## Class methods ##
                          ###################

    def self.test_for_integer(num)
      Integer(num)
    end

    def self.test_name(name)
      raise ArgumentError.new "Name length is under 1" if name.length <= 1
      name
    end

    def self.test_for_vin(vin)
      raise ArgumentError.new("Vin must be 17 characters") unless vin.length == 17
      vin
    end

    def self.get_data
      file_path = '/Users/Cynthia/Documents/Ada/queues/ruby_exercises/ruby_week5/ride-share-two/support/drivers.csv'
      data = FileData.new(file_path)
      data.read_csv_and_remove_headings
    end

    # this method will return mock data for testing when you need to call find
    # but this can also cause lots of problems with other specs
    # you need mock data to correlate across all three classes
    #
    # def self.get_data
    #   [
    #     ['500', 'Jane Doe', 'WX1234567890ABCDE'],
    #     ['501', 'John Smith','WX1234567890ABCDE'],
    #     ['502', 'Cyn Bin','ZZ1234567890ABCDE'],
    #     ['503', 'Ms. Squishy','YY1234567890ABCDE'],
    #     ['505', 'Travis Crosby','XX1234567890ABCDE']
    #   ]
    # end

    def self.test_data_for_duplicates(drivers)
      driver_ids = drivers.map { |driver| driver.id }
      if driver_ids.length != driver_ids.uniq.length
        duplicates = driver_ids.detect { |id| driver_ids.count(id) > 1 }
        # would be nice to know the ids of the duplicate id
        raise ArgumentError.new("There are two drivers with the same id: #{duplicates}")
      end
      drivers
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

      test_data_for_duplicates(drivers)
      return drivers
    end

    def self.find(driver_id)
      drivers = all
      drivers.each { |driver| return driver if driver.id == driver_id }
      nil
    end
  end
end
