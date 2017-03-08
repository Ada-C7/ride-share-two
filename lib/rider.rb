
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
  end
  #
  # Retrieve a list of all previous driver instances this rider has rode with.
  #   input: Array of Trip instances (from above)
  #   output: Array of the associated drivers.

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
end
