require 'csv'

module RideShare
  class Trip

    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_info)
      #have an ID, rider ID, a driver ID, date, rating
      @trip_info = trip_info[:trip_id]
      @driver_id = trip_info[:driver_id]
      @rider_id = trip_info[:trip_info]
      @date = trip_info[:date]

      #Each rating should be within an acceptable range (1-5)
      raise ArgumentError.new("A valid rating is 1-5") if trip_info[:rating] > 5 || trip_info[:rating] < 1
      @rating = trip_info[:rating]
    end

    def self.create_all_trips
      # retrieve all trips from the CSV file
      csv_contents = CSV.read("support/trips.csv")
      csv_contents.shift
      #http://stackoverflow.com/questions/11740439/how-can-i-skip-the-header-row-when-reading-a-csv-in-ruby
      #http://stackoverflow.com/questions/5347949/whats-different-between-each-and-collect-method-in-ruby
      csv_contents.collect do |single_trip_info|
        Trip.new(
        trip_id: single_trip_info[0].to_i,
        driver_id: single_trip_info[1].to_i,
        rider_id: single_trip_info[2].to_i,
        date: single_trip_info[3].to_datetime, #http://ruby-doc.org/stdlib-2.4.0/libdoc/date/rdoc/DateTime.html#method-i-to_datetime
        rating: single_trip_info[4].to_i
        )
      end
    end

    def find_all_driver_trips(driver_id)
      # find all trip instances for a given driver ID
      # http://stackoverflow.com/questions/2244915/how-do-i-search-within-an-array-of-hashes-by-hash-values-in-ruby
      self.create_all_trips.find_all { |trip| trip[driver_id] == driver_id }
    end

    def find_all_rider_trips(rider_id)
      # find all trip instances for a given rider ID

    end


    # def self.find(driver_id)
    #   # find a specific driver using their numeric ID
    #   self.create_all_drivers[driver_id]
    # end



  end
end
