
class RideShare::Driver
  attr_reader :id, :name, :vin

  def initialize(id, name, vin)
    @id = id
    @name = name

    unless vin.length == 17
      raise InvalidVinError.new("VIN numbers should be 17 characters")
    end
    @vin = vin
  end

  def trips
    RideShare::Trip.find_all_driver(@id)
  end

  # def average_rating
  #   retrieve an average rating for that driver based on all trips taken.
  #     input: ARRAY of trips that this driver has taken
  #     output: Average star rating FIXNUM
  #
  # end
end
