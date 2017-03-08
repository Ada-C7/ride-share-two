require 'csv'
module Rideshare
  class Trip
    attr_reader  :driver_id, :rider_id, :rating, :trip_id

    def initialize(trip_hash)
      @trip_id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]

    end

    def self.create_trips
      hash = {}
      CSV.foreach('support/trips.csv', {:headers => true, :header_converters=> :symbol}) do |row|
       hash[row[0]] = Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]})
     end
     return hash
    end


    def self.find_by_driver(param)
      array = []
      CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
      array = Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[1] == param.to_s
      end
      return array
    end

    def self.find_rider(param)
      array =[]
      CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
      array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[2] == param.to_s
      end
      return array
    end
    def find_rider_id(param)
    #helper method to extract rider_id from trip object
      Rideshare::Trip.find_rider(param)[0].rider_id
    end
    #
    # def find_driver_id(param)
    # #helper method to extract driver_id from trip object
    #   Rideshare::Trip.find_driver(param)[0].driver_id
    # end
    # def find_rider(param)
    #   Rideshare::Rider.find_rider(self.find_rider(param)[rider_id])
    #   end
    # end

    # find_driver(param)
    #    self.create_trips unless trips_created?
    #   if @alltrips.each |array| do
    #    array[1] == param
    #    driver_id = csv.open driver_id
    #    return driver_id
    #   end
    # end
  end
end
#
driver = Rideshare::Trip.find_by_rider(147)[0]
print driver

#
#
#
