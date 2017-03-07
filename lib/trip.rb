class RideShare::Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

  def initialize(trip_hash)
    raise ArgumentError.new("Rating must be between 1-5") if !(trip_hash[:rating].between?(1,5))

    @id = RideShare::validate_int(trip_hash[:id], "Trip ID")
    @driver_id = RideShare::validate_int(trip_hash[:driver_id], "Driver ID")
    @rider_id = RideShare::validate_int(trip_hash[:rider_id], "Rider ID")
    @date = RideShare::validate_string(trip_hash[:date], "Date")
    @rating = RideShare::validate_int(trip_hash[:rating], "Rating")
  end

  def self.all
    
  end
end
