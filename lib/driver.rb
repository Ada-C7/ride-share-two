module RideShare
  class Driver
    attr_reader :driver_id, :vin
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @driver_id = hash[:driver_id]
      raise ArgumentError.new("VIn number must contain 17 character only") if hash[:vin].to_s.length != 17
      @vin = hash[:vin]
    end

    def trips
      # RideShare::Trips.all_trips_by_driver
    end









  end
end

driver_hash = {driver_id: 2, license: 3044043, vin: 12213449}
