
  class RideShare::Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date,
    :rating

    def initialize(trip_data)
      @trip_id = trip_data[:trip_id]
      @driver_id = trip_data[:driver_id]
      @rider_id = trip_data[:rider_id]
      @date = trip_data[:date]
      @rating = trip_data[:rating]
    end

    def driver
    end

    def trip
    end

    def self.all
      trip_array = []
      CSV.open("support/trips.csv", 'r').each do |trip|
        new_trip = RideShare::Trip.new({
          :trip_id => trip[0],
          :driver_id => trip[1],
          :rider_id => trip[2],
          :date => trip[3],
          :rating => trip[4]
          })
          trip_array << new_trip
      end
      trip_array.shift
      return trip_array
    end

    def self.all_drivers(id)
      trips = RideShare::Trip.all
      drivers = trips.select { |t| t.driver_id == id }
      return drivers
    end

    def self.all_riders(id)
      trips = RideShare::Trip.all
      riders = trips.select { |t| t.rider_id == id }
      return riders
    end

  end
