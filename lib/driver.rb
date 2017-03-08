class RideShare::Driver
  attr_reader :id, :name, :vin

  def initialize(driver_hash)
    @id = RideShare::validate_int(driver_hash[:id], "Driver ID")
    @name = RideShare::validate_string(driver_hash[:name], "Name")
    @vin = RideShare::validate_string(driver_hash[:vin], "VIN")
  end

  def self.all
    drivers = []
    CSV.read("support/drivers.csv")[1..-1].each do |line|
      drivers << RideShare::Driver.new( {
        id: line[0].to_i,
        name: line[1],
        vin: line[2]
      } )
    end
    return drivers
  end

  def self.find(id)
    drivers = RideShare::Driver.all
    drivers.each do |driver|
      return driver if id == driver.id
    end
    raise NoDriverError.new("Driver with that ID does not exist")
  end
end
