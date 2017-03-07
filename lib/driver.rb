class RideShare::Driver
  attr_reader :id, :name, :vin

  def initialize(driver_hash)
    raise ArgumentError.new("Driver id must be an integer") if driver_hash[:id].class != Integer
    raise ArgumentError.new("Name must be a non-empty string") if driver_hash[:name].class != String || driver_hash[:name] == ""
    raise ArgumentError.new("VIN must be a non-empty string") if driver_hash[:vin].class != String || driver_hash[:vin] == ""

    @id = driver_hash[:id]
    @name = driver_hash[:name]
    @vin = driver_hash[:vin]
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
end
