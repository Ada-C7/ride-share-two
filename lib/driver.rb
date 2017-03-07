module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @vin = info[:vin]
    end

    def self.all(drivers_data)
      drivers = drivers_data.map do |driver_info|
        driver = Hash.new
        driver[:id] = test_for_integer(driver_info[0])
        driver[:name] = test_for_string(driver_info[1])
        driver[:vin] = test_for_vin(driver_info[2])
        self.new(driver)
      end
      return drivers
    end

    def self.test_for_integer(num)
      Integer(num)
    end

    def self.test_for_string(name)
      name
    end

    def self.test_for_vin(vin)
      raise ArgumentError unless vin.length == 17
      vin
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
