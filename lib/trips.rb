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
      self.all.select { |trip| trip.rider_id == id }
    end

    def self.driver_find(id)
      self.all.select { |trip| trip.driver_id == id}
    end

    def self.find(id)
      self.all.find { |account| account.id == id }
    end

    def driver_for_trip
      RideShare::Driver.find(@driver_id)
    end

    def rider_for_trip
      RideShare::Rider.find(@rider_id)
    end

  end
end

# initialization_hash = {
#   trip_id: 1,
#   driver_id: 2,
#   rider_id: 2,
#   date: "4/26/2017",
#   rating: 5
#     }
# trip = RideShare::Trip.new(initialization_hash)
#
# puts trip.rider_for_trip.name
#
# puts "hi"
