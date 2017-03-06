module RideShare
  class Driver
    attr_reader :driver_id, :license, :vin
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @driver_id = hash[:driver_id]
      @license = hash[:license]
      @vin = hash[:vin]
    end







  end
end

driver_hash = {driver_id: 2, license: 3044043, vin: 122189973449}
