require "csv"

module RideShareTwo
  class Driver

    attr_reader :driver_id, :name, :vin

    def initialize(driver_id, name, vin)
      @driver_id = driver_id
      @name = name
      @vin = vin
        raise ArgumentError.new("vin number is more or less than 17 characters") if vin.length != 17
    end

    def self.all_drivers
        all_drivers = []
        CSV.open("support/drivers.csv",{:headers => true}).each do |array|
            all_drivers << self.new(array[0], array[1], array[2].to_s)
        end
        return all_drivers
    end

  end

end
