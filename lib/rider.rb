class RideShare::Rider
  attr_reader :id, :name, :phone

  def initialize(rider_hash)
    @id = rider_hash[:id]
    @name = rider_hash[:name]
    @phone = rider_hash[:phone]
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
