require_relative 'module'
module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(params)
      @id = params[:trip_id].to_i
      @driver_id = params[:driver_id].to_i
      @rider_id = params[:rider_id].to_i
      @date = params[:date]
      @rating = params[:rating].to_i
      raise ArgumentError.new "The rating must be between 1 and 5" if @rating > 5 || @rating < 0
    end

    def self.all
      csv = CSV.open('./support/trips.csv', :headers => true, :header_converters => :symbol)
      csv.map { |row| self.new(row.to_hash) }
    end

    def self.rider_find(id)
      rider_trips = self.all.select { |trip| trip.rider_id == id }
      raise ArgumentError.new "Sorry, this rider has no trips" if rider_trips.length < 1
      rider_trips
    end

    def self.driver_find(id)
      driver_trips = self.all.select { |trip| trip.driver_id == id}
      raise ArgumentError.new "Sorry, this driver has no trips" if driver_trips.length < 1
      driver_trips
    end

    def self.find(id)
      self.all.find { |account| account.id == id }
    end

    def driver_for_trip
      driver = RideShare::Driver.find(@driver_id)
      raise ArgumentError.new "This driver does not exist" if driver == nil
      driver
    end

    def rider_for_trip
      rider = RideShare::Rider.find(@rider_id)
      raise ArgumentError.new "This rider does not exist" if rider == nil
      rider
    end

  end
end

# initialization_hash = {
#   trip_id: 1,
#   driver_id: 0,
#   rider_id: 0,
#   date: "4/26/2017",
#   rating: 5
#     }
# trip = RideShare::Trip.new(initialization_hash)
#
# puts trip.rider_for_trip.name
#
# puts "hi"
