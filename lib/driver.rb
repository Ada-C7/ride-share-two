
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

  def average_rating
    total = 0
    trips.each { |trip| total += trip.rating }

    rating = (total.to_f / trips.length)
    return rating.round(1)
  end

  def self.find_all
    drivers = []
    CSV.open("support/drivers.csv").each do |driver|
      begin
        drivers << RideShare::Driver.new(driver[0].to_i, driver[1], driver[2])
      rescue InvalidVinError => e
        puts "#{ e }"
      end
    end

    return drivers
  end

  def self.find_driver(driver_id)
    all_drivers = RideShare::Driver.find_all
    found_driver = all_drivers.find { |driver| driver.id == driver_id }

    return 0 if found_driver == nil
    return found_driver
  end

end
