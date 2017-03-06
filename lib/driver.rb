module RideShare
  class Driver
    def initialize(hash)
      @driver_id = hash[:driver_id]
      @license = hash[:license]
      @vin = hash[:vin]
    end







  end
end

driver_hash = {driver_id: 2, license: 3044043, vin: 122189973449}
