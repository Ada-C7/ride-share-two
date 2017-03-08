class Driver
  attr_reader :id, :name, :vin
  # create new driver and take in id, name, vin
  def initialize(driver_info={})
    @id = driver_info[:id]
    @name = driver_info[:name]
    @vin = driver_info[:vin] if driver_info[:vin] == 17
  end
end

driver = Driver.new(id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4")
puts driver.id
puts driver.name
puts driver.vin
