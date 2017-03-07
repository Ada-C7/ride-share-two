
module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin
    end


    def self.all
      drivers_array = []
      CSV.read("support/drivers.csv", {:headers => true}).each do |driver|
        drivers_array << (Driver.new(driver[0], driver[1], driver[2]))
      end
      drivers_array
    end

    def self.find(id)
      account_array = RideShare::Driver.all
      account_array.each do |driver|
        if id == driver.id
          return driver
        end
      end
      # raise ArgumentError.new "Driver #{id} does not exist"
    end

  end #class

end #Module
