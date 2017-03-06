module RideShare
  class Rider
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @rider_id = hash[:rider_id]
      @name = hash[:name]
      @phone = hash[:phone]
    end

  end
end

rider_hash = {32, "Natalia", "1425394958"}
