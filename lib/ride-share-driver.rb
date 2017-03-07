require 'csv'

module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin

    end

    def self.all
      all_drivers = []

      csv_data = CSV.read("support/drivers.csv")
      csv_data.shift

      csv_data.each do |line|
        all_drivers << Driver.new(line[0].to_i, line[1].to_s, line[2].to_s)
      end
      return all_drivers
    end

    def self.find(id)
      drivers = RideShare::Driver.all
      return drivers.find {|driver| driver.id == id }
    end

    def to_s
      "id: #{ @id }, name: #{ @name }, VIN: #{ @vin }"
    end
  end

end
