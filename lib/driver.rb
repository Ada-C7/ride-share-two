module RideShare
  class Driver < Uber
    attr_reader :id, :name
    SOURCE_FILE = "support/drivers.csv"

    def initialize(params)
      validate_params(params, [:id, :name, :vin])

      @id = params[:id]
      @name = params[:name]
      @vin = params[:vin]
      @trips = params[:trips]
    end

    def self.all
      @@all ||= super(SOURCE_FILE)
    end

    def self.earnings(fare)
      raise ArgumentError.new("Invalid Fare: Below $5.15 minimum.") if fare < 5.15
      ride_fee = 1.65
      earn_rate = 0.80

      ((fare - ride_fee) * earn_rate).round(2)
    end

    def trips
      @trips ||= Trip.by_driver(@id)
    end

    def average_rating
      return nil if trips.empty?
      trips.map { |trip| trip.rating }.reduce(:+).to_f/(trips.length).round(1)
    end

    def total_earnings
      fares = trips.map { |trip| trip.fare }
      fares.inject(0) { |total, fare| total + Driver.earnings(fare) }.round(2)
    end

    private
    VIN_LENGTH = 17

    def validate_params(params, required_attributes)
      super
      if params[:vin].length != VIN_LENGTH
        raise ArgumentError.new("VIN must be #{VIN_LENGTH} characters.")
      end
    end

  end
end
