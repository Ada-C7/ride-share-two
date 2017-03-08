
class RideShare::Rider
  attr_reader :id, :name, :phone

  def initialize(id, name, phone)
    unless id > 0
      raise InvalidIDError.new("Rider IDs must be an Integer grater than 0")
    end

    @id = id
    @name = name
    @phone = phone
  end

  def trips
    RideShare::Trip.find_all_rider(@id)
  end

  def drivers
    rider_trips = trips
    rider_drivers = []

    rider_trips.each do |trip|
      rider_drivers << RideShare::Driver.find_driver(trip.driver_id)
    end

    return rider_drivers

  end

  def self.find_all
    riders = []

    CSV.open("support/riders.csv").each do |rider|
      begin
        riders << RideShare::Rider.new(rider[0].to_i, rider[1], rider[2])
      rescue InvalidIDError => e
        puts "#{ e }"
      end
    end
    return riders
  end

  def self.find_rider(rider_id)
    all_riders = RideShare::Rider.find_all
    found_rider = all_riders.find { |rider| rider.id == rider_id }
    return 0 if found_rider == nil
    return found_rider
  end
end
