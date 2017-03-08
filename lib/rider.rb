
class RideShare::Rider
  attr_reader :id, :name, :phone

  def initialize(id, name, phone)
    @id = id
    @name = name
    @phone = phone
  end

  def trips
    RideShare::Trip.find_all_rider(@id)
  end
  # Retrieve a list of trips only this rider has taken
  #   input: Rider ID
  #   output: Array of Trip instances
end
