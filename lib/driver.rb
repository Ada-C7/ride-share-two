require 'csv'
module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(info)
      @id = info[:id]
      @name = info[:name]
      @vin = info[:vin]
    end


    def self.all(csv_file)
      drivers = CSV.read(csv_file)
      drivers.shift

      drivers.map! do |driver_info|
        driver = Hash.new
        driver[:id] = driver_info[0].to_i
        driver[:name] = driver_info[1]
        driver[:vin] = driver_info[2]
        driver_info = driver
      end

      drivers.map! { |info| self.new(info) }
      return drivers
    end

    # return nil if the account does not exist
    def self.find(driver_id, file)
      drivers = all(file)
      drivers.each { |info| return info if info.id == driver_id }
      nil
    end
  end
end
