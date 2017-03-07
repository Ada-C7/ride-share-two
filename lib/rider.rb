class RideShare::Rider
  attr_reader :id, :name, :phone

  def initialize(rider_hash)
    @id = RideShare::validate_int(rider_hash[:id], "Rider ID")
    @name = RideShare::validate_string(rider_hash[:name], "Name")
    @phone = RideShare::validate_string(rider_hash[:phone], "Phone Number")
  end

  def self.all
    riders = []
    CSV.read("support/riders.csv")[1..-1].each do |line|
      riders << RideShare::Rider.new( {
        id: line[0].to_i,
        name: line[1],
        phone: line[2]
      } )
    end
    return riders
  end
end
