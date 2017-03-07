class Driver
  attr_reader :id, :name, :vin

  def initialize(driver_hash)
    raise ArgumentError.new("Driver id must be an integer") if driver_hash[:id].class != Integer
    raise ArgumentError.new("Name must be a non-empty string") if driver_hash[:name].class != String || driver_hash[:name] == ""
    raise ArgumentError.new("VIN must be a non-empty string") if driver_hash[:vin].class != String || driver_hash[:vin] == ""

    @id = driver_hash[:id]
    @name = driver_hash[:name]
    @vin = driver_hash[:vin]
  end
end
