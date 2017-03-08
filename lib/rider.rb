
class RideShare::Rider
  attr_reader :id, :name, :phone
  
  def initialize(id, name, phone)
    @id = id
    @name = name
    @phone = phone
  end
  # Each rider should be instantiated (INITIALIZE) with an ID, name and phone number
  #   input: Rider.new
  #   output: new rider object.

end
