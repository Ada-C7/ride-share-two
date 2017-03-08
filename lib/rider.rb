module RideShare
  class Rider
    attr_reader :id, :name, :trips

    def initialize(params)
      validate_params(params)

      @id = params[:id]
      @name = params[:name]
      @phone_number = params[:phone_number]
      @trips = params[:trips]
      @trips ||= []
    end

    def self.all
      @@all ||= CSV.read("support/riders.csv", headers:true).map do |line|
        Rider.new(
          id: Integer(line[0]),
          name: line[1],
          phone_number: line[2]
        )
      end
    end

    def self.find(target_id)
      all.find { |rider| rider.id == target_id }
    end

    def import_trips
      @trips = Trip.by_rider(@id)
    end

    def drivers
      @trips.map { |trip| Driver.find(trip.driver_id) }
    end

    private

    def validate_params(params)
      required_attributes = [:id, :name, :phone_number]

      missing = required_attributes.select do |attribute|
        !params.keys.include? attribute || params[attribute].nil? || params[attribute].empty?
      end

      unless missing.empty?
        raise ArgumentError.new("Missing parameter(s): #{missing.join(", ")}")
      end
    end

  end
end
