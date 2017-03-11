module RideShare
  class Uber

    MIN_FARE = 5.15
    RATE_PER_MINUTE = 0.24
    RATE_PER_MILE = 1.35
    BOOKING_FEE = 1.65
    BASE_FARE = 1.35
    DRIVER_RIDE_FEE = 1.65
    DRIVER_EARN_RATE = 0.80

    def self.fare(duration, distance)
      fare = BASE_FARE + BOOKING_FEE + (duration * RATE_PER_MINUTE) + (distance * RATE_PER_MILE)
      [MIN_FARE,fare.round(2)].max
    end

    def self.all(source_file)
      DataImport.import_attributes(source_file).map do |params|
        self.new(params)
      end
    end

    def self.find(target_id)
      all.find { |object| object.id == target_id }
    end

    private

    def validate_params(params, required_attributes)
      missing = required_attributes.select do |attribute|
        !params.keys.include?(attribute) || params[attribute].to_s.empty?
      end

      unless missing.empty?
        raise ArgumentError.new("Missing parameter(s): #{missing.join(", ")}")
      end
    end

  end
end
