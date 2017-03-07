require 'csv'

module Ride_share_two
  class Trip

    def initialize(trip_id, driver_id,rider_id, date, rating)
      # raise ArgumentError.new("rating must include? [1,2,3,4,5]")
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
      @riders = []
    end

    def self.rider
      @riders = []
      CSV.read("../support/riders.csv").each do |line|
        @riders << self.new(line[0].to_s,line[1].to_s,line[2].to_s)
      end
      return @riders[1]
    end

  end
end

rider1 = Ride_share_two::Trip.new(trip_id, driver_id,rider_id, date, rating)
p rider1.riders
