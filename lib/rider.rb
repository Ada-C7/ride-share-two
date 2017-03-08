
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
    #leaving this to come back
    #send trips back to trips to find the driver instances!
    # driver_ids = trips.map { |trip| trip.driver_id }
    #
    # Retrieve a list of all previous driver instances this rider has rode with.
    #   input: Array of Trip instances (from above)
    #   output: Array of the associated drivers.
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

  def self.find_rider(id)
    all_riders = RideShare::Rider.find_all
    found_rider = all_riders.find { |rider| rider.id == id }
    return 0 if found_rider == nil
    return found_rider
    # Retrieve specific rider using numeric ID
    #   input: Rider ID
    #   output: Specific rider (from list above)

  end
end
