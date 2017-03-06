module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @rider_id = hash[:rider_id]
      @name = hash[:name]
      @phone = hash[:phone]
    end

  end
end

rider_hash = {rider_id: 32, name: "Natalia", phone:  "1425394958"}
