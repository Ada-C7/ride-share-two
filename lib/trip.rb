module RideShare
  class Trip < Uber
    attr_reader :id, :rider_id, :driver_id, :date, :rating
    SOURCE_FILE = "support/trips.csv"

    def initialize(params)
      validate_params(params)

      @id = params[:id]
      @rider_id = params[:rider_id]
      @driver_id = params[:driver_id]
      @date = params[:date]
      @rating = params[:rating]
    end

    def self.all
      @@all ||= super(SOURCE_FILE)
    end

    def self.by_driver(target_driver_id)
      all.select { |trip| trip.driver_id == target_driver_id }
    end

    def self.by_rider(target_rider_id)
      all.select { |trip| trip.rider_id == target_rider_id }
    end

    def driver
      Driver.find(@driver_id)
    end

    def rider
      Rider.find(@rider_id)
    end

    private

    def validate_params(params)
      required_attributes = [:id, :rider_id, :driver_id, :date, :rating]

      missing = required_attributes.select do |attribute|
        !params.keys.include?(attribute) || params[attribute].to_s.empty?
      end

      if !missing.empty?
        raise ArgumentError.new("Missing parameter(s): #{missing.join(", ")}")
      elsif !params[:rating].between?(1,5)
        raise ArgumentError.new("Rating must be between 1 and 5.")
      end
    end

  end
end
