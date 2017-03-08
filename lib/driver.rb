
class RideShare::Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name
    @vin = vin
  end
  # Each driver should be INSTANTIATED (initialize) with an ID, name and VIN (VIN must bse specific length to make sure it is actually a vin)
  #   input: Driver.new
  #   output: new instance of Driver with associated ID, Name and VIN.  Each of those should be ACCESSIBLE (attr_reader)
end
